//
//  RecommendationsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit

let textCellIdentifier = "workoutCell"

class RecommendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var workouts: [Workout] = [
           Workout(name: "Heavy Squat Workout", duration: "45 min", imageName: "squat", exercises: [
            Exercise(name: "Barbell Squat", sets: 4, reps: 8, rest: "90 sec"),
            Exercise(name: "Leg Press", sets: 3, reps: 10, rest: "60 sec")
        ]),
           Workout(name: "HIIT Workout", duration: "30 min", imageName: "hiit", exercises: [
            Exercise(name: "Burpees", sets: 3, reps: 15, rest: "30 sec"),
            Exercise(name: "Jump Squats", sets: 3, reps: 12, rest: "30 sec")
        ])
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
            let workout = workouts[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = workout.name
            content.secondaryText = workout.duration
            content.image = UIImage(named: workout.imageName)
            cell.contentConfiguration = content
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkoutDetail",
           let destination = segue.destination as? WorkoutDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destination.workout = workouts[indexPath.row]
        }
    }

}
