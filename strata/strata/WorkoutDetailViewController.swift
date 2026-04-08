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
    @IBOutlet weak var bodyPartsWorkedLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutLabel.text = workout?.name
        /*if let bodyParts = workout?.bodyPartsWorked {
            bodyPartsWorkedLabel.text = "Body Parts Worked: " + bodyParts.joined(separator: ", ") }
        difficultyLevelLabel.text = "Difficulty Level: \(workout?.difficulty ?? "")"
        durationLabel.text = "Duration: \(workout?.duration, default: "") mins" */
        if let bodyParts = workout?.bodyPartsWorked {
            setBoldTitle(for: bodyPartsWorkedLabel, title: "Body Parts Worked", value: bodyParts.joined(separator: ", "))
        }
        setBoldTitle(for: difficultyLevelLabel, title: "Difficulty Level", value: workout?.difficulty ?? "")
        if let duration = workout?.duration {
            setBoldTitle(for: durationLabel, title: "Duration", value: "\(duration) mins")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func setBoldTitle(for label: UILabel, title: String, value: String) {
        let fullText = "\(title): \(value)"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Bold only the title (before the colon)
        let titleRange = NSRange(location: 0, length: title.count)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: label.font.pointSize), range: titleRange)
        
        // Regular font for the rest
        let valueRange = NSRange(location: title.count, length: fullText.count - title.count)
        attributedText.addAttribute(.font, value: label.font!, range: valueRange)
        
        label.attributedText = attributedText
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
