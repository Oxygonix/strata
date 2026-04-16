//
//  RecommendationsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

let textCellIdentifier = "workoutCell"

class RecommendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var recommendations: [Workout] = []
    var userEquipment: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
//        getRecommendations()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let workout = self.recommendations[indexPath.row]
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
            destination.workout = self.recommendations[indexPath.row]
        }
    }

    func getUserInfo() {
        self.userEquipment.removeAll()
        let user = Auth.auth().currentUser
        let docRef = db.collection("users").document("\(user!.uid)")
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                let equipment = document.data()?["equipment"] as? [String: Bool] ?? [:]
                let hasCables = equipment["cables"]!
                let hasMat = equipment["mat"]!
                let hasBench = equipment["bench"]!
                let hasBarbell = equipment["barbells"]!
                let hasDumbbells = equipment["dumbbells"]!
                let hasKettlebells = equipment["kettlebell"]!
                if hasCables { self.userEquipment.insert("Cables") }
                if hasMat { self.userEquipment.insert("Mat") }
                if hasDumbbells { self.userEquipment.insert("Dumbbells") }
                if hasBarbell { self.userEquipment.insert("Barbell") }
                if hasKettlebells { self.userEquipment.insert("Kettlebells") }
                if hasBench { self.userEquipment.insert("Bench") }
                self.getRecommendations()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getRecommendations() {
        self.recommendations = workouts.filter { workout in
            for item in workout.equipmentUsed {
                if item == "Machine" {
                    continue
                }
                if !userEquipment.contains(item) {
                    return false
                }
            }
            return true
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
