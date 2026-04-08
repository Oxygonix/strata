//
//  ChosenWorkout.swift
//  strata
//
//  Created by Torres, Ian on 4/7/26.
//

import UIKit
import SwiftUI
import Charts

class ChosenWorkout: UIViewController {

    @IBOutlet weak var dateRange: UISegmentedControl!
    @IBOutlet weak var currentWorkouts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let hostingController = UIHostingController(rootView: WorkoutChartView())

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: dateRange.bottomAnchor, constant: 40),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 250)])
        
        dateRange.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateRange.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            dateRange.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateRange.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateRange.heightAnchor.constraint(equalToConstant: 32)
        ])

        hostingController.didMove(toParent: self)
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
