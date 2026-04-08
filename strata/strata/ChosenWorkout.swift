//
//  ChosenWorkout.swift
//  strata
//
//  Created by Torres, Ian on 4/7/26.
//

import UIKit
import SwiftUI
import Charts

class ChosenWorkout: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateRange: UISegmentedControl!
    @IBOutlet weak var currentWorkouts: UITableView!

    let workouts: [(name: String, muscle: String)] = [
        ("Preacher Curl", "Biceps"),
        ("Bench Press", "Chest")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        currentWorkouts.dataSource = self
        currentWorkouts.delegate = self

        let hostingController = UIHostingController(rootView: WorkoutChartView())

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: dateRange.bottomAnchor, constant: 40),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 250),

            currentWorkouts.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: 20),
            currentWorkouts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWorkouts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWorkouts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workouts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutRowCell", for: indexPath) as! WorkoutRowCell

        let workout = workouts[indexPath.row]
        cell.configure(workoutName: workout.name, muscleGroup: workout.muscle)

        return cell
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
    let workouts = [
        WorkoutPoint(day: 1, weight: 135),
        WorkoutPoint(day: 2, weight: 145),
        WorkoutPoint(day: 3, weight: 150),
        WorkoutPoint(day: 4, weight: 160)
    ]

    var body: some View {
        VStack {
            Chart {
                LinePlot(
                    workouts,
                    x: .value("Day", \.day),
                    y: .value("Weight", \.weight)
                )
            }
            .frame(height: 300)
        }
        .padding()
    }
}
