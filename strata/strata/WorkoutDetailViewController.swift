//
//  WorkoutDetailViewController.swift
//  strata
//
//  Created by Sanjana Madhav on 4/3/26.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workout : Workout?
    
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutLabel.text = workout?.name
        durationLabel.text = workout?.duration
        tableView.delegate = self
        tableView.dataSource = self
        self.hidesBottomBarWhenPushed = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

                let exercise = workout!.exercises[indexPath.row]

                var content = cell.defaultContentConfiguration()
                content.text = exercise.name
                content.secondaryText = "\(exercise.sets) sets • \(exercise.reps) reps • Rest: \(exercise.rest)"

                cell.contentConfiguration = content

                return cell
    }
    
    

}
