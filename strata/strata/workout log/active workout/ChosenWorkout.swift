import UIKit
import SwiftUI
import Charts
import Combine

struct WorkoutExercise {
    var name: String
    var muscle: String
    var sets: [WorkoutSet]
    var chartPoints: [WorkoutPoint]
}

final class WorkoutChartModel: ObservableObject {
    @Published var title: String = "Preacher Curl"
    @Published var points: [WorkoutPoint] = [
        WorkoutPoint(day: 1, weight: 15),
        WorkoutPoint(day: 2, weight: 20),
        WorkoutPoint(day: 3, weight: 20),
        WorkoutPoint(day: 4, weight: 25)
    ]
}

class ChosenWorkout: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateRange: UISegmentedControl!
    @IBOutlet weak var currentWorkouts: UITableView!

    private var chartHost: UIHostingController<WorkoutChartView>?
    private let chartModel = WorkoutChartModel()

    private var workouts: [WorkoutExercise] = [
        WorkoutExercise(
            name: "Preacher Curl",
            muscle: "Biceps",
            sets: [
                WorkoutSet(weight: 15, reps: 12),
                WorkoutSet(weight: 20, reps: 12)
            ],
            chartPoints: [
                WorkoutPoint(day: 1, weight: 15),
                WorkoutPoint(day: 2, weight: 20),
                WorkoutPoint(day: 3, weight: 20),
                WorkoutPoint(day: 4, weight: 25)
            ]
        ),
        WorkoutExercise(
            name: "Bench Press",
            muscle: "Chest",
            sets: [
                WorkoutSet(weight: 135, reps: 8),
                WorkoutSet(weight: 145, reps: 8)
            ],
            chartPoints: [
                WorkoutPoint(day: 1, weight: 135),
                WorkoutPoint(day: 2, weight: 145),
                WorkoutPoint(day: 3, weight: 150),
                WorkoutPoint(day: 4, weight: 155)
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        currentWorkouts.dataSource = self
        currentWorkouts.delegate = self

        setUpChart()
        setUpAddExerciseFooter()

        if let first = workouts.first {
            updateChart(for: first)
        }

        DispatchQueue.main.async {
            if !self.workouts.isEmpty {
                let firstIndexPath = IndexPath(row: 0, section: 0)
                self.currentWorkouts.selectRow(at: firstIndexPath, animated: false, scrollPosition: .none)
                self.tableView(self.currentWorkouts, didSelectRowAt: firstIndexPath)
            }
        }
    }
    
    private func deleteSet(from workoutIndex: Int, setIndex: Int) {
        guard workouts.indices.contains(workoutIndex),
              workouts[workoutIndex].sets.indices.contains(setIndex) else { return }

        workouts[workoutIndex].sets.remove(at: setIndex)

        currentWorkouts.reloadRows(at: [IndexPath(row: workoutIndex, section: 0)], with: .automatic)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFooterLayout()
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else {
                completionHandler(false)
                return
            }

            self.workouts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if let firstWorkout = self.workouts.first {
                self.updateChart(for: firstWorkout)

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
                sets: [WorkoutSet(weight: 0, reps: 0)],
                chartPoints: self.generateDummyPoints(seed: self.workouts.count + 1)
            )

            self.workouts.append(newExercise)
            self.currentWorkouts.reloadData()

            let newIndexPath = IndexPath(row: self.workouts.count - 1, section: 0)
            self.currentWorkouts.selectRow(at: newIndexPath, animated: true, scrollPosition: .bottom)
            self.tableView(self.currentWorkouts, didSelectRowAt: newIndexPath)
        }

        present(picker, animated: true)
    }

    private func generateDummyPoints(seed: Int) -> [WorkoutPoint] {
        let base = Double(10 + (seed * 5))
        return [
            WorkoutPoint(day: 1, weight: base),
            WorkoutPoint(day: 2, weight: base + 5),
            WorkoutPoint(day: 3, weight: base + 3),
            WorkoutPoint(day: 4, weight: base + 8),
            WorkoutPoint(day: 5, weight: base + 10)
        ]
    }

    private func updateChart(for workout: WorkoutExercise) {
        chartModel.title = workout.name
        chartModel.points = workout.chartPoints
    }

    private func addSet(to workoutIndex: Int) {
        workouts[workoutIndex].sets.append(WorkoutSet(weight: 0, reps: 0))
        currentWorkouts.reloadRows(at: [IndexPath(row: workoutIndex, section: 0)], with: .automatic)
    }

    private func updateSet(at workoutIndex: Int, setIndex: Int, weight: Int, reps: Int) {
        guard workouts.indices.contains(workoutIndex),
              workouts[workoutIndex].sets.indices.contains(setIndex) else { return }

        workouts[workoutIndex].sets[setIndex].weight = weight
        workouts[workoutIndex].sets[setIndex].reps = reps
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutRowCell", for: indexPath) as! WorkoutRowCell
        let workout = workouts[indexPath.row]

        cell.configure(
            workoutName: workout.name,
            muscleGroup: workout.muscle,
            sets: workout.sets
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

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateChart(for: workouts[indexPath.row])

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

struct WorkoutPoint: Identifiable {
    let id = UUID()
    let day: Int
    let weight: Double
}

struct WorkoutChartView: View {
    @ObservedObject var model: WorkoutChartModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(model.title)
                .font(.headline)
                .padding(.horizontal)

            Chart(model.points) { point in
                LineMark(
                    x: .value("Day", point.day),
                    y: .value("Weight", point.weight)
                )
                PointMark(
                    x: .value("Day", point.day),
                    y: .value("Weight", point.weight)
                )
            }
            .frame(height: 220)
            .padding(.horizontal)
        }
        .padding(.top, 8)
    }
}
