//
//  RecommendationsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit

let textCellIdentifier = "TextCell"

class RecommendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var workouts: [Workout] = [
           Workout(name: "Heavy Squat Workout", duration: "45 min", imageName: "squat"),
           Workout(name: "Shoulder/Chest Workout", duration: "45 min", imageName: "chest"),
           Workout(name: "Leg Cooldown Workout", duration: "30 min", imageName: "cooldown"),
           Workout(name: "HIIT Workout", duration: "30 min", imageName: "hiit")
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
        <#code#>
    }

}
