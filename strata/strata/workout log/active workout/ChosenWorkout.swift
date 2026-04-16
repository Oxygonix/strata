import UIKit
import SwiftUI
import Charts
import Combine
import FirebaseAuth
import FirebaseFirestore

struct WorkoutSet {
    var weight: Int
    var reps: Int

    init(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
    }

    init?(dictionary: [String: Any]) {
        guard
            let weight = dictionary["weight"] as? Int,
            let reps = dictionary["reps"] as? Int
        else {
            return nil
        }

        self.weight = weight
        self.reps = reps
    }

    var dictionary: [String: Any] {
        [
            "weight": weight,
            "reps": reps
        ]
    }
}

struct WorkoutExercise {
    var name: String
    var muscle: String
    var muscles: [String: Int]
    var sets: [WorkoutSet]
    var intensity: Int
    var chartPoints: [WorkoutPoint]

    init(
        name: String,
        muscle: String,
        muscles: [String: Int],
        sets: [WorkoutSet],
        intensity: Int,
        chartPoints: [WorkoutPoint]
    ) {
        self.name = name
        self.muscle = muscle
        self.muscles = muscles
        self.sets = sets
        self.intensity = intensity
        self.chartPoints = chartPoints
    }

    init?(dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let muscles = dictionary["muscles"] as? [String: Int]
        else {
            return nil
        }

        let setsArray = dictionary["sets"] as? [[String: Any]] ?? []
        let parsedSets = setsArray.compactMap { WorkoutSet(dictionary: $0) }
        let intensity = dictionary["intensity"] as? Int ?? 1

        let primaryMuscle = muscles
            .max(by: { $0.value < $1.value })?
            .key
            .replacingOccurrences(of: "_", with: " ")
            .capitalized ?? "Custom"

        self.name = name
        self.muscle = primaryMuscle
        self.muscles = muscles
        self.sets = parsedSets
        self.intensity = intensity
        self.chartPoints = ChosenWorkout.makeChartPoints(from: parsedSets)
    }

    var dictionary: [String: Any] {
        [
            "name": name,
            "muscles": muscles,
            "sets": sets.map(\.dictionary),
            "intensity": intensity
        ]
    }
}

struct WorkoutPoint: Identifiable {
    let id = UUID()
    let bucketDate: Date
    let weight: Double
    let label: String
}

enum ChartRange {
    case week
    case month
    case year
}

final class WorkoutChartModel: ObservableObject {
    @Published var title: String = "No Exercise Selected"
    @Published var points: [WorkoutPoint] = []
}

struct WorkoutChartView: View {
    @ObservedObject var model: WorkoutChartModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(model.title)
                .font(.headline)
                .padding(.horizontal)

            if model.points.isEmpty {
                Text("Add sets to see progress.")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            } else {
                Chart(model.points) { point in
                    LineMark(
                        x: .value("Date", point.bucketDate),
                        y: .value("Weight", point.weight)
                    )

                    PointMark(
                        x: .value("Date", point.bucketDate),
                        y: .value("Weight", point.weight)
                    )
                }
                .chartXAxis {
                    AxisMarks(values: model.points.map(\.bucketDate)) { value in
                        AxisGridLine()
                        AxisTick()
                        if let dateValue = value.as(Date.self),
                           let point = model.points.first(where: { Calendar.current.isDate($0.bucketDate, equalTo: dateValue, toGranularity: .day) || $0.bucketDate == dateValue }) {
                            AxisValueLabel(point.label)
                        }
                    }
                }
                .frame(height: 220)
                .padding(.horizontal)
            }
        }
        .padding(.top, 8)
    }
}

class ChosenWorkout: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateRange: UISegmentedControl!
    @IBOutlet weak var currentWorkouts: UITableView!

    var workoutDocumentId: String?
    var workoutTitle: String?

    private let db = Firestore.firestore()
    private var chartHost: UIHostingController<WorkoutChartView>?
    private let chartModel = WorkoutChartModel()
    private var exercisesForWorkout: [WorkoutExercise] = []
    private var selectedExerciseName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = workoutTitle ?? "Workout"

        currentWorkouts.dataSource = self
        currentWorkouts.delegate = self
        dateRange.addTarget(self, action: #selector(dateRangeChanged), for: .valueChanged)

        setUpChart()
        setUpAddExerciseFooter()
        fetchWorkout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFooterLayout()
    }
    
    private func updateIntensity(at exerciseIndex: Int, intensity: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex) else { return }

        exercisesForWorkout[exerciseIndex].intensity = intensity
        saveExercisesToFirestore()
    }
    
    private func loadHistoryForExercise(named exerciseName: String) {
        guard let user = Auth.auth().currentUser else { return }

        selectedWorkoutDate { [weak self] anchorDate in
            guard let self = self, let anchorDate = anchorDate else { return }

            self.db.collection("users")
                .document(user.uid)
                .collection("WorkoutLogs")
                .order(by: "workoutDate", descending: false)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Failed to load exercise history: \(error.localizedDescription)")
                        return
                    }

                    let documents = snapshot?.documents ?? []
                    let calendar = Calendar.current
                    let range = self.currentChartRange()

                    var bestByBucket: [Date: Double] = [:]
                    let formatter = DateFormatter()

                    switch range {
                    case .week:
                        formatter.dateFormat = "M/d"
                    case .month:
                        formatter.dateFormat = "M/yy"
                    case .year:
                        formatter.dateFormat = "yyyy"
                    }

                    for doc in documents {
                        guard
                            let data = doc.data() as? [String: Any],
                            let workoutTimestamp = data["workoutDate"] as? Timestamp
                        else {
                            continue
                        }

                        let workoutDate = workoutTimestamp.dateValue()

                        if workoutDate > anchorDate {
                            continue
                        }

                        let exercises = data["exercises"] as? [[String: Any]] ?? []

                        guard let exercise = exercises.first(where: {
                            ($0["name"] as? String) == exerciseName
                        }) else {
                            continue
                        }

                        let sets = exercise["sets"] as? [[String: Any]] ?? []
                        let maxWeight = sets.compactMap { $0["weight"] as? Int }.max() ?? 0

                        let bucketStart: Date?

                        switch range {
                        case .week:
                            let startOfAnchorDay = calendar.startOfDay(for: anchorDate)
                            let startOfWorkoutDay = calendar.startOfDay(for: workoutDate)
                            let daysDiff = calendar.dateComponents([.day], from: startOfWorkoutDay, to: startOfAnchorDay).day ?? 0

                            guard daysDiff >= 0 && daysDiff < 7 else { continue }
                            bucketStart = startOfWorkoutDay

                        case .month:
                            guard let anchorWeek = calendar.dateInterval(of: .weekOfYear, for: anchorDate)?.start,
                                  let workoutWeek = calendar.dateInterval(of: .weekOfYear, for: workoutDate)?.start
                            else { continue }

                            let weeksDiff = calendar.dateComponents([.weekOfYear], from: workoutWeek, to: anchorWeek).weekOfYear ?? 0
                            guard weeksDiff >= 0 && weeksDiff < 8 else { continue }
                            bucketStart = workoutWeek

                        case .year:
                            guard let anchorYear = calendar.dateInterval(of: .year, for: anchorDate)?.start,
                                  let workoutYear = calendar.dateInterval(of: .year, for: workoutDate)?.start
                            else { continue }

                            let yearDiff = calendar.dateComponents([.year], from: workoutYear, to: anchorYear).year ?? 0
                            guard yearDiff >= 0 else { continue }
                            bucketStart = workoutYear
                        }

                        guard let bucket = bucketStart else { continue }

                        if let existing = bestByBucket[bucket] {
                            bestByBucket[bucket] = max(existing, Double(maxWeight))
                        } else {
                            bestByBucket[bucket] = Double(maxWeight)
                        }
                    }

                    let points = bestByBucket.keys.sorted().map { bucketDate in
                        WorkoutPoint(
                            bucketDate: bucketDate,
                            weight: bestByBucket[bucketDate] ?? 0,
                            label: formatter.string(from: bucketDate)
                        )
                    }

                    self.chartModel.title = exerciseName
                    self.chartModel.points = points
                }
        }
    }
    
    @objc private func dateRangeChanged() {
        guard let exerciseName = selectedExerciseName else { return }
        loadHistoryForExercise(named: exerciseName)
    }
    
    private func currentChartRange() -> ChartRange {
        switch dateRange.selectedSegmentIndex {
        case 0: return .week
        case 1: return .month
        default: return .year
        }
    }

    private func selectedWorkoutDate(completion: @escaping (Date?) -> Void) {
        guard
            let user = Auth.auth().currentUser,
            let workoutDocumentId = workoutDocumentId
        else {
            completion(nil)
            return
        }

        db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .document(workoutDocumentId)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Failed to fetch selected workout date: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                guard
                    let data = snapshot?.data(),
                    let timestamp = data["workoutDate"] as? Timestamp
                else {
                    completion(nil)
                    return
                }

                completion(timestamp.dateValue())
            }
    }

    private func fetchWorkout() {
        guard
            let user = Auth.auth().currentUser,
            let workoutDocumentId = workoutDocumentId
        else { return }

        db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .document(workoutDocumentId)
            .getDocument { [weak self] snapshot, error in
                guard let self = self else { return }

                if let error = error {
                    print("Failed to fetch workout: \(error.localizedDescription)")
                    return
                }

                guard let data = snapshot?.data() else { return }

                let exerciseArray = data["exercises"] as? [[String: Any]] ?? []
                self.exercisesForWorkout = exerciseArray.compactMap { WorkoutExercise(dictionary: $0) }
                self.currentWorkouts.reloadData()

                if let firstExercise = self.exercisesForWorkout.first {
                    self.updateChart(for: firstExercise)

                    DispatchQueue.main.async {
                        let firstIndexPath = IndexPath(row: 0, section: 0)
                        self.currentWorkouts.selectRow(at: firstIndexPath, animated: false, scrollPosition: .none)
                        self.tableView(self.currentWorkouts, didSelectRowAt: firstIndexPath)
                    }
                } else {
                    self.chartModel.title = "No Exercise Selected"
                    self.chartModel.points = []
                }
            }
    }

    private func saveExercisesToFirestore(completion: (() -> Void)? = nil) {
        guard
            let user = Auth.auth().currentUser,
            let workoutDocumentId = workoutDocumentId
        else { return }

        let payload = exercisesForWorkout.map(\.dictionary)

        db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .document(workoutDocumentId)
            .updateData([
                "exercises": payload
            ]) { error in
                if let error = error {
                    print("Failed to save exercises: \(error.localizedDescription)")
                    return
                }

                completion?()
            }
    }

    private func setUpChart() {
        let host = UIHostingController(rootView: WorkoutChartView(model: chartModel))
        chartHost = host

        addChild(host)
        view.addSubview(host.view)
        host.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: dateRange.bottomAnchor, constant: 40),
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.heightAnchor.constraint(equalToConstant: 250),

            currentWorkouts.topAnchor.constraint(equalTo: host.view.bottomAnchor, constant: 20),
            currentWorkouts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWorkouts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWorkouts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        host.didMove(toParent: self)
    }

    private func setUpAddExerciseFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: currentWorkouts.bounds.width, height: 88))
        footerView.backgroundColor = .clear

        let button = UIButton(type: .system)
        button.setTitle("Add Exercise", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor(red: 0.792, green: 0.169, blue: 0.192, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(addExerciseTapped), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 16, width: footerView.bounds.width - 40, height: 52)
        button.autoresizingMask = [.flexibleWidth]

        footerView.addSubview(button)
        currentWorkouts.tableFooterView = footerView
    }

    private func updateFooterLayout() {
        guard let footerView = currentWorkouts.tableFooterView else { return }
        var frame = footerView.frame
        frame.size.width = currentWorkouts.bounds.width
        footerView.frame = frame
        currentWorkouts.tableFooterView = footerView
    }

    static func makeChartPoints(from sets: [WorkoutSet]) -> [WorkoutPoint] {
        []
    }

    private func updateChart(for workout: WorkoutExercise) {
        selectedExerciseName = workout.name
        loadHistoryForExercise(named: workout.name)
    }
    
    private func addSet(to exerciseIndex: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex) else { return }

        view.endEditing(true)

        exercisesForWorkout[exerciseIndex].sets.append(WorkoutSet(weight: 0, reps: 0))
        exercisesForWorkout[exerciseIndex].chartPoints = []

        currentWorkouts.reloadRows(at: [IndexPath(row: exerciseIndex, section: 0)], with: .automatic)

        saveExercisesToFirestore { [weak self] in
            guard let self = self else { return }
            if let selected = self.currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
                self.selectedExerciseName = self.exercisesForWorkout[exerciseIndex].name
                self.loadHistoryForExercise(named: self.exercisesForWorkout[exerciseIndex].name)
            }
        }
    }

    private func updateSet(at exerciseIndex: Int, setIndex: Int, weight: Int, reps: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex),
              exercisesForWorkout[exerciseIndex].sets.indices.contains(setIndex) else { return }

        exercisesForWorkout[exerciseIndex].sets[setIndex].weight = weight
        exercisesForWorkout[exerciseIndex].sets[setIndex].reps = reps
        exercisesForWorkout[exerciseIndex].chartPoints = []

        saveExercisesToFirestore { [weak self] in
            guard let self = self else { return }
            if let selected = self.currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
                self.selectedExerciseName = self.exercisesForWorkout[exerciseIndex].name
                self.loadHistoryForExercise(named: self.exercisesForWorkout[exerciseIndex].name)
            }
        }
    }

    private func deleteSet(from exerciseIndex: Int, setIndex: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex),
              exercisesForWorkout[exerciseIndex].sets.indices.contains(setIndex) else { return }

        view.endEditing(true)

        exercisesForWorkout[exerciseIndex].sets.remove(at: setIndex)
        exercisesForWorkout[exerciseIndex].chartPoints = []

        currentWorkouts.reloadRows(at: [IndexPath(row: exerciseIndex, section: 0)], with: .automatic)

        saveExercisesToFirestore { [weak self] in
            guard let self = self else { return }
            if let selected = self.currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
                self.selectedExerciseName = self.exercisesForWorkout[exerciseIndex].name
                self.loadHistoryForExercise(named: self.exercisesForWorkout[exerciseIndex].name)
            }
        }
    }

    @objc private func addExerciseTapped() {
        let picker = ExercisePickerViewController()
        picker.modalPresentationStyle = .pageSheet

        picker.onExerciseSelected = { [weak self] selectedExercise in
            guard let self = self else { return }

            let primaryMuscle = selectedExercise.muscles
                .max(by: { $0.value < $1.value })?
                .key
                .replacingOccurrences(of: "_", with: " ")
                .capitalized ?? "Custom"

            let newExercise = WorkoutExercise(
                name: selectedExercise.name,
                muscle: primaryMuscle,
                muscles: selectedExercise.muscles,
                sets: [WorkoutSet(weight: 0, reps: 0)],
                intensity: 1,
                chartPoints: []
            )

            self.exercisesForWorkout.append(newExercise)
            self.currentWorkouts.reloadData()
            self.saveExercisesToFirestore()
            self.selectedExerciseName = newExercise.name
            self.loadHistoryForExercise(named: newExercise.name)

            let newIndexPath = IndexPath(row: self.exercisesForWorkout.count - 1, section: 0)
            self.currentWorkouts.selectRow(at: newIndexPath, animated: true, scrollPosition: .bottom)
            self.tableView(self.currentWorkouts, didSelectRowAt: newIndexPath)
        }

        present(picker, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else {
                completionHandler(false)
                return
            }

            self.exercisesForWorkout.remove(at: indexPath.row)
            self.saveExercisesToFirestore()
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if let firstExercise = self.exercisesForWorkout.first {
                self.updateChart(for: firstExercise)
                let firstIndexPath = IndexPath(row: 0, section: 0)
                tableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .none)
            } else {
                self.chartModel.title = "No Exercise Selected"
                self.chartModel.points = []
            }

            completionHandler(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercisesForWorkout.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutRowCell", for: indexPath) as! WorkoutRowCell
        let exercise = exercisesForWorkout[indexPath.row]

        cell.configure(
            workoutName: exercise.name,
            muscleGroup: exercise.muscle,
            sets: exercise.sets,
            intensity: exercise.intensity
        )

        cell.onAddSet = { [weak self] in
            self?.addSet(to: indexPath.row)
        }

        cell.onSetChanged = { [weak self] setIndex, weight, reps in
            self?.updateSet(at: indexPath.row, setIndex: setIndex, weight: weight, reps: reps)
        }

        cell.onDeleteSet = { [weak self] setIndex in
            self?.deleteSet(from: indexPath.row, setIndex: setIndex)
        }

        cell.onIntensityChanged = { [weak self] intensity in
            self?.updateIntensity(at: indexPath.row, intensity: intensity)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)

        let exercise = exercisesForWorkout[indexPath.row]
        selectedExerciseName = exercise.name
        loadHistoryForExercise(named: exercise.name)

        if let cell = tableView.cellForRow(at: indexPath) as? WorkoutRowCell {
            cell.setSelected(true, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WorkoutRowCell {
            cell.setSelected(false, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}
