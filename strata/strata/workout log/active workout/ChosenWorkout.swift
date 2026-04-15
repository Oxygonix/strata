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
    let day: Int
    let weight: Double
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
                        x: .value("Set", point.day),
                        y: .value("Weight", point.weight)
                    )

                    PointMark(
                        x: .value("Set", point.day),
                        y: .value("Weight", point.weight)
                    )
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = workoutTitle ?? "Workout"

        currentWorkouts.dataSource = self
        currentWorkouts.delegate = self

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

    private func saveExercisesToFirestore() {
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
                }
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
        guard !sets.isEmpty else { return [] }

        return sets.enumerated().map { index, set in
            WorkoutPoint(day: index + 1, weight: Double(set.weight))
        }
    }

    private func updateChart(for workout: WorkoutExercise) {
        chartModel.title = workout.name
        chartModel.points = Self.makeChartPoints(from: workout.sets)
    }

    private func addSet(to exerciseIndex: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex) else { return }

        exercisesForWorkout[exerciseIndex].sets.append(WorkoutSet(weight: 0, reps: 0))
        exercisesForWorkout[exerciseIndex].chartPoints = Self.makeChartPoints(from: exercisesForWorkout[exerciseIndex].sets)

        currentWorkouts.reloadRows(at: [IndexPath(row: exerciseIndex, section: 0)], with: .automatic)

        if let selected = currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
            updateChart(for: exercisesForWorkout[exerciseIndex])
        }

        saveExercisesToFirestore()
    }

    private func updateSet(at exerciseIndex: Int, setIndex: Int, weight: Int, reps: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex),
              exercisesForWorkout[exerciseIndex].sets.indices.contains(setIndex) else { return }

        exercisesForWorkout[exerciseIndex].sets[setIndex].weight = weight
        exercisesForWorkout[exerciseIndex].sets[setIndex].reps = reps
        exercisesForWorkout[exerciseIndex].chartPoints = Self.makeChartPoints(from: exercisesForWorkout[exerciseIndex].sets)

        if let selected = currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
            updateChart(for: exercisesForWorkout[exerciseIndex])
        }

        saveExercisesToFirestore()
    }

    private func deleteSet(from exerciseIndex: Int, setIndex: Int) {
        guard exercisesForWorkout.indices.contains(exerciseIndex),
              exercisesForWorkout[exerciseIndex].sets.indices.contains(setIndex) else { return }

        exercisesForWorkout[exerciseIndex].sets.remove(at: setIndex)
        exercisesForWorkout[exerciseIndex].chartPoints = Self.makeChartPoints(from: exercisesForWorkout[exerciseIndex].sets)

        currentWorkouts.reloadRows(at: [IndexPath(row: exerciseIndex, section: 0)], with: .automatic)

        if let selected = currentWorkouts.indexPathForSelectedRow, selected.row == exerciseIndex {
            updateChart(for: exercisesForWorkout[exerciseIndex])
        }

        saveExercisesToFirestore()
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
                chartPoints: [WorkoutPoint(day: 1, weight: 0)]
            )

            self.exercisesForWorkout.append(newExercise)
            self.currentWorkouts.reloadData()
            self.saveExercisesToFirestore()

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
        updateChart(for: exercisesForWorkout[indexPath.row])

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
