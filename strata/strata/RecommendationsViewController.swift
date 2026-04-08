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
            content.secondaryText = "\(workout.duration) mins"
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
