//
//  RecommendationsViewController.swift
//  strata
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
        setupView()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
    }

    private func setupView() {
        view.backgroundColor = UIColor.systemGroupedBackground
        let titleLabel = UILabel()
        titleLabel.text = "Recommended Workouts"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 92
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recommendations.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let workout = recommendations[indexPath.row]

        var content = UIListContentConfiguration.subtitleCell()
        content.text = workout.name
        content.secondaryText = "\(workout.duration) min workout"
        content.image = UIImage(systemName: iconName(for: workout.name))
        content.imageProperties.tintColor = UIColor.systemRed
        content.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)

        content.textProperties.font = .systemFont(ofSize: 20, weight: .semibold)
        content.textProperties.color = .label

        content.secondaryTextProperties.font = .systemFont(ofSize: 15, weight: .medium)
        content.secondaryTextProperties.color = .secondaryLabel

        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18)
        cell.contentConfiguration = content

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = UIColor.secondarySystemGroupedBackground
        background.cornerRadius = 22
        background.strokeColor = UIColor.separator.withAlphaComponent(0.15)
        background.strokeWidth = 1
        cell.backgroundConfiguration = background

        var selectedBackground = UIBackgroundConfiguration.clear()
        selectedBackground.backgroundColor = UIColor.systemGray5
        selectedBackground.cornerRadius = 22
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .clear
        cell.multipleSelectionBackgroundView = UIView()

        cell.backgroundColor = .clear
        cell.clipsToBounds = false

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    private func iconName(for workoutName: String) -> String {
        let name = workoutName.lowercased()

        // Chest
        if name.contains("chest") || name.contains("pec") {
            return "figure.strengthtraining.traditional"
        }

        // Back
        if name.contains("back") || name.contains("lat") || name.contains("trap") || name.contains("pull") {
            return "figure.rower"
        }

        // Legs
        if name.contains("leg") || name.contains("quad") || name.contains("hamstring") ||
            name.contains("glute") || name.contains("calf") {
            return "figure.run"
        }

        // Arms
        if name.contains("arm") || name.contains("bicep") || name.contains("tricep") ||
            name.contains("forearm") || name.contains("dumbbell"){
            return "dumbbell"
        }

        // Core
        if name.contains("core") || name.contains("ab") || name.contains("abs") ||
            name.contains("oblique") {
            return "figure.core.training"
        }

        // Full body
        if name.contains("full body") || name.contains("fullbody") || name.contains("total body") {
            return "figure.mixed.cardio"
        }

        // Upper body
        if name.contains("upper body") || name.contains("upperbody") || name.contains("upper") {
            return "figure.strengthtraining.functional"
        }

        // Generic fallback
        return "bolt.heart.fill"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkoutDetail",
           let destination = segue.destination as? WorkoutDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destination.workout = recommendations[indexPath.row]
        }
    }

    func getUserInfo() {
        userEquipment.removeAll()

        guard let user = Auth.auth().currentUser else { return }

        let docRef = db.collection("users").document(user.uid)
        docRef.getDocument { [weak self] document, err in
            guard let self = self else { return }

            if let document = document, document.exists {
                let equipment = document.data()?["equipment"] as? [String: Bool] ?? [:]

                let hasCables = equipment["cables"] ?? false
                let hasMat = equipment["mat"] ?? false
                let hasBench = equipment["bench"] ?? false
                let hasBarbells = equipment["barbells"] ?? false
                let hasDumbbells = equipment["dumbbells"] ?? false
                let hasKettleBell = equipment["kettlebell"] ?? false

                if hasCables { self.userEquipment.insert("Cables") }
                if hasMat { self.userEquipment.insert("Mat") }
                if hasDumbbells { self.userEquipment.insert("Dumbbells") }
                if hasBarbells { self.userEquipment.insert("Barbells") }
                if hasKettleBell { self.userEquipment.insert("Kettle Bell") }
                if hasBench { self.userEquipment.insert("Bench") }

                self.getRecommendations()
            } else {
                print("Document does not exist")
            }
        }
    }

    func getRecommendations() {
        recommendations = workouts.filter { workout in
            let requiredEquipment = Set(workout.exercises.flatMap { $0.equipment })

            for item in requiredEquipment {
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
