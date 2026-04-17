//
//  HeatMapViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/8/26.
//

import UIKit
import Macaw
import FirebaseFirestore
import FirebaseAuth

struct WorkoutLog {
    let id: String
    let title: String
    let date: Date
    let exercises: [ExerciseLog]
}

struct ExerciseLog {
    let name: String
    let intensity: Int
    let muscles: [String: Int]
    let sets: [ExerciseSet]
}

struct ExerciseSet {
    let reps: Int
    let weight: Double
}

struct WorkoutLogCellModel {
    let workoutTitle: String
    let exercises: [ExerciseSummary]
    let isEmptyState: Bool
}

struct ExerciseSummary {
    let name: String
    let setsSummary: String
}

// Single or Group of Muscles
var musclesFront: [String: Int] = [
    "Chest": 1,
    "Biceps": 0,
    "Shoulders": 0,
    "Traps": 0,
    "Forearms": 0,
    "Abs": 1,
    "Obliques": 1,
    "Adductors": 1,
    "Abductors": 0,
    "Calves": 0,
    "Quads": 0
]

let musclesBack: [String: Int] = [
    "Glutes": 1,
    "Hamstrings": 0,
    "Rear Delts": 0,
    "Lats": 1,
    "Triceps": 0,
    "Traps": 1,
    "Forearms": 0,
    "Adductors": 1,
    "Abductors": 0,
    "Calves": 0,
    "Obliques": 0
]

let allMuscles = Set(musclesFront.keys).union(Set(musclesBack.keys))

class HeatMapViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    var bodyNode: Node!
    var showingFront = true
    var isDetailVisible = false
    var frontSVG: String = ""
    var backSVG: String = ""
    
    var workoutLogs: [WorkoutLog] = []
    
    var detailView = UIView()
    var trailingConstraint: NSLayoutConstraint?
    let detailViewWidth: CGFloat = 250
    let detailViewHeight: CGFloat = 600
    var hasInitializedDetailView: Bool = false
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var intensityImageView: UIImageView!
    var highlightedMuscle: String? = nil
    
    var segmentedControl: UISegmentedControl!
    var tableView: UITableView!
    var recentLogItems: [WorkoutLogCellModel] = []
    var recommendationItems: [Workout] = []
    
    @IBOutlet weak var heatMapContainer: MacawView!
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        setupDetailView()
        detailView.isUserInteractionEnabled = true
        heatMapContainer.isUserInteractionEnabled = true
        tableView.isUserInteractionEnabled = true
        UserDefaults.standard.set(false, forKey: "hasSeenHeatmapWelcome") // Testing
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDetailVisible, highlightedMuscle != nil {
            helloLabel.alpha = 0
            applyHighlightMode()
        }
        
        let isDark = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        helloLabel.textColor = isDark ? .white : .black
        getUserInfo()
        getWorkoutLogs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let hasSeenWelcome = UserDefaults.standard.bool(forKey: "hasSeenHeatmapWelcome")
        
        if !hasSeenWelcome {
            showWelcomeAlert()
            UserDefaults.standard.set(true, forKey: "hasSeenHeatmapWelcome")
        }
    }
    
    func setupDetailView() {
        // Set up detail view
        detailView.backgroundColor = UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        detailView.layer.cornerRadius = 25
        detailView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        detailView.clipsToBounds = true
        trailingConstraint = detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: detailViewWidth)
        
        NSLayoutConstraint.activate([
            detailView.centerYAnchor.constraint(equalTo: heatMapContainer.centerYAnchor),
            detailView.widthAnchor.constraint(equalToConstant: detailViewWidth),
            detailView.heightAnchor.constraint(equalToConstant: detailViewHeight),
            trailingConstraint!
        ])
        
        // Set up detail labels
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textColor = .white
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        detailView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
        
        // Setup intensity image view
        intensityImageView = UIImageView()
        intensityImageView.translatesAutoresizingMaskIntoConstraints = false
        intensityImageView.contentMode = .scaleAspectFit
        detailView.addSubview(intensityImageView)
        detailView.addSubview(subtitleLabel)
        
        titleLabel.text = "Muscle"
        subtitleLabel.text = "Intensity"

        NSLayoutConstraint.activate([
            intensityImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            intensityImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            intensityImageView.heightAnchor.constraint(equalToConstant: 40),
            intensityImageView.widthAnchor.constraint(equalToConstant: 60),
            
            subtitleLabel.centerYAnchor.constraint(equalTo: intensityImageView.centerYAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: intensityImageView.trailingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        // Setup Segmented Control
        segmentedControl = UISegmentedControl(items: ["Recent Logs", "Recommendations"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 10, weight: .medium)
        segmentedControl.setTitleTextAttributes([.font: font], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        detailView.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: intensityImageView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
        
        // Setup Tableview
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        detailView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -15)
        ])
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDetailSwipe(_:)))
        swipeRight.direction = .right
        detailView.addGestureRecognizer(swipeRight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return recentLogItems.count
        case 1:
            return recommendationItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .label

        switch segmentedControl.selectedSegmentIndex {

        case 0:
            let item = recentLogItems[indexPath.row]

            if item.isEmptyState {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear

                let label = UILabel()
                label.text = "No recent logs for this muscle"
                label.textAlignment = .center
                label.textColor = .gray
                label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                label.numberOfLines = 0

                label.translatesAutoresizingMaskIntoConstraints = false

                cell.contentView.addSubview(label)

                NSLayoutConstraint.activate([
                    label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                    label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                    label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 12),
                    label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -12)
                ])

                return cell
            }

            let exercisesText = item.exercises.map {
                "\($0.name): \($0.setsSummary)"
            }.joined(separator: "\n")

            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .label

            cell.textLabel?.text = item.workoutTitle
            cell.detailTextLabel?.text = exercisesText
            cell.detailTextLabel?.numberOfLines = 0

        case 1:
            let workout = recommendationItems[indexPath.row]
            cell.textLabel?.text = workout.name
            cell.detailTextLabel?.text = "\(workout.duration) min • \(workout.difficulty)"

        default:
            break
        }

        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.detailTextLabel?.textColor = .darkGray

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch segmentedControl.selectedSegmentIndex {

        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            return

        case 1:
            let selectedWorkout = recommendationItems[indexPath.row]

            let storyboard = UIStoryboard(name: "Recommendations", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "WorkoutDetailViewController") as? WorkoutDetailViewController else { return }

            vc.workout = selectedWorkout

            if let nav = self.navigationController {
                nav.pushViewController(vc, animated: true)
            } else {
                print("No navigation controller found")
            }

        default:
            return
        }
    }
    
    func difficultyRank(_ difficulty: String) -> Int {
        switch difficulty {
        case "Beginner": return 1
        case "Intermediate": return 2
        case "Advanced": return 3
        default: return 0
        }
    }
    
    func getUserInfo() {
        let user = Auth.auth().currentUser
        let docRef = db.collection("users").document("\(user!.uid)")
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                var name = document.data()!["name"] as? String ?? "User"
                if name == "" {
                    name = "User"
                }
                self.helloLabel.text = "Hello \(name)!"

                let sex = document.data()!["sex"] as? String ?? "female"
                if sex == "male" {
                    self.frontSVG = "Male-Front"
                    self.backSVG = "Male-Back"
                    musclesFront["Traps"] = 0
                } else {
                    self.frontSVG = "Female-Front"
                    self.backSVG = "Female-Back"
                    musclesFront["Traps"] = 1
                }

                if !self.isDetailVisible {
                    UIView.animate(withDuration: 0.8) {
                        self.helloLabel.alpha = 1
                    }
                } else {
                    self.helloLabel.alpha = 0
                }
                
                let svgName = self.showingFront ? self.frontSVG : self.backSVG
                self.loadBodySVG(named: svgName)
                
                self.attachTapHandlers(view: self.heatMapContainer)
                self.fillAllMuscles(front: self.showingFront)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getWorkoutLogs() {
        guard let user = Auth.auth().currentUser else { return }
        
        let logsRef = db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .order(by: "workoutDate", descending: true)
        
        logsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching workout logs: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.workoutLogs = documents.compactMap { doc -> WorkoutLog? in
                
                let data = doc.data()
                
                let title = data["title"] as? String ?? "Workout"
                let timestamp = data["workoutDate"] as? Timestamp ?? Timestamp()
                let date = timestamp.dateValue()
                
                guard let exerciseArray = data["exercises"] as? [[String: Any]] else {
                    return WorkoutLog(id: doc.documentID, title: title, date: date, exercises: [])
                }
                
                let exercises: [ExerciseLog] = exerciseArray.compactMap { exerciseData in
                    
                    let name = exerciseData["name"] as? String ?? "Unknown"
                    let intensity = exerciseData["intensity"] as? Int ?? 1
                    let muscles = exerciseData["muscles"] as? [String: Int] ?? [:]
                    let setsArray = exerciseData["sets"] as? [[String: Any]] ?? []
                    
                    let sets: [ExerciseSet] = setsArray.compactMap { setData in
                        guard let reps = setData["reps"] as? Int else { return nil }
                        let weight = setData["weight"] as? Double ?? 0
                        return ExerciseSet(reps: reps, weight: weight)
                    }
                    
                    return ExerciseLog(name: name, intensity: intensity, muscles: muscles, sets: sets)
                }
                
                return WorkoutLog(
                    id: doc.documentID,
                    title: title,
                    date: date,
                    exercises: exercises
                )
            }
            
            print("Loaded \(self.workoutLogs.count) workout logs")
            DispatchQueue.main.async {
                let svgName = self.showingFront ? self.frontSVG : self.backSVG
                self.loadBodySVG(named: svgName)
                self.attachTapHandlers(view: self.heatMapContainer)
                self.fillAllMuscles(front: self.showingFront)
            }
        }
    }
    
    func computeFatiguePerMuscle(from logs: [WorkoutLog]) -> [String: Double] {
        
        var fatigue: [String: Double] = [:]
        for muscle in allMuscles {
            fatigue[muscle] = 0
        }
        
        let now = Date()
        
        for log in logs {
            
            let daysAgo = Calendar.current.dateComponents([.day], from: log.date, to: now).day ?? 0
            let decayRate = 0.5
            let timeDecay = exp(-decayRate * Double(daysAgo))
            
            for exercise in log.exercises {
                for (muscle, activation) in exercise.muscles {
                    guard fatigue[muscle] != nil else { continue }
                    
                    let intensity = exercise.intensity
                    let constant = 2.5
                    let stimulus = Double(activation * intensity) * constant
                    let weightedStimulus = stimulus * timeDecay
                    
                    let currentFatigue = fatigue[muscle] ?? 0
                    let adjusted = weightedStimulus * (1.0 - currentFatigue / 100.0)
                    
                    fatigue[muscle]! += adjusted
                    fatigue[muscle]! = min(fatigue[muscle]!, 100)
                }
            }
        }
        
        return fatigue
    }
    
    func fatigueToLevel(_ fatigue: Double) -> Int {
        switch fatigue {
        case 0..<20: return 1
        case 20..<40: return 2
        case 40..<60: return 3
        case 60..<80: return 4
        default: return 5
        }
    }
    
    func fatigueToColor(_ fatigue: Double) -> Color {
        let normalized = min(max(fatigue / 100.0, 0.0), 1.0)

        // optional: makes the ramp feel less linear / more natural
        let t = pow(normalized, 1.5)

        let r = 255
        let g = Int(255 * (1.0 - t))
        let b = Int(255 * (1.0 - t))

        return Color.rgb(r: r, g: g, b: b)
    }
    
    func fillMuscleWithFatigue(name: String, fatigue: Double) {
        let color = fatigueToColor(fatigue)
        let structureMap = showingFront ? musclesFront : musclesBack
        
        guard let isSingleLayer = structureMap[name] else {
            print("Warning: \(name) not defined in structure map")
            return
        }
        
        if isSingleLayer == 1 {
            if let shape = bodyNode.nodeBy(tag: name) as? Shape {
                shape.fill = color
            }
        } else {
            if let group = bodyNode.nodeBy(tag: name) as? Group {
                for node in group.contents {
                    if let shape = node as? Shape {
                        shape.fill = color
                    }
                }
            }
        }
    }
    
    func loadBodySVG(named svgName: String) {
        do {
            bodyNode = try SVGParser.parse(resource: svgName)
            heatMapContainer.node = bodyNode
            heatMapContainer.backgroundColor = .clear
            heatMapContainer.contentMode = .scaleAspectFit
        } catch {
            print("Error loading SVG \(svgName): \(error)")
        }
    }
    
    func fillAllMuscles(front: Bool) {
        
        let fatigueMap = computeFatiguePerMuscle(from: workoutLogs)
        let musclesToRender = front ? musclesFront : musclesBack
        for muscle in musclesToRender.keys {
            let fatigue = fatigueMap[muscle] ?? 0
            fillMuscleWithFatigue(name: muscle, fatigue: fatigue)
        }
        
        if let highlighted = highlightedMuscle, isDetailVisible {
            applyHighlightMode()
        }
    }
    
    func attachTapHandlers(view: MacawView) {
        let muscles = showingFront ? musclesFront : musclesBack
        for muscle in muscles.keys {
            if let node = view.node.nodeBy(tag: muscle) {
                propagateTap(in: node, layerId: muscle)
            } else {
                print("node for \(muscle) not found")
            }
        }
    }
    
    func propagateTap(in node: Node, layerId: String) {
        node.onTap { [weak self] _ in
            print("Tapped layer: \(layerId)")
            self?.handleLayerTap(layerId: layerId)
        }

        if let group = node as? Group {
            for child in group.contents {
                propagateTap(in: child, layerId: layerId)
            }
        }
    }
    
    func handleLayerTap(layerId: String) {

        highlightedMuscle = layerId
        if isDetailVisible {
            updateView(layerId: layerId)
            return
        }
        
        let container = self.view!
        let shift = container.frame.width / 2
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75, delay: 0, options: [.curveEaseInOut]) {
            self.heatMapContainer.transform = CGAffineTransform(translationX: -shift, y: 0)
            self.trailingConstraint?.constant = 0
            self.view.layoutIfNeeded()
            self.updateView(layerId: layerId)
            self.helloLabel.alpha = 0
        }
        isDetailVisible = true
    }
    
    func updateView(layerId: String) {

        highlightMuscle(layerId)
        
//        let data = showingFront ? muscleHeatmapFront : muscleHeatmapBack
//        let intensity = data[layerId] ?? 1
        
        let fatigueMap = computeFatiguePerMuscle(from: workoutLogs)
        let fatigue = fatigueMap[layerId] ?? 0
        let intensity = fatigueToLevel(fatigue)
        
        let intensityDescription: String
        switch intensity {
            case 1: intensityDescription = "Rested"
            case 2: intensityDescription = "Light fatigue"
            case 3: intensityDescription = "Moderate fatigue"
            case 4: intensityDescription = "High fatigue"
            case 5: intensityDescription = "Extreme fatigue"
            default: intensityDescription = "Unknown"
        }

        if !hasInitializedDetailView {
            titleLabel.text = layerId
            subtitleLabel.text = intensityDescription
            intensityImageView.image = UIImage(named: "\(intensity)")
            
            titleLabel.alpha = 1
            subtitleLabel.alpha = 1
            intensityImageView.alpha = 1
            
            hasInitializedDetailView = true
        } else {
            
            UIView.animate(withDuration: 0.15, animations: {
                self.titleLabel.alpha = 0
                self.subtitleLabel.alpha = 0
                self.intensityImageView.alpha = 0
            }) { _ in
                
                self.titleLabel.text = layerId
                self.subtitleLabel.text = intensityDescription
                self.intensityImageView.image = UIImage(named: "\(intensity)")
                
                UIView.animate(withDuration: 0.25) {
                    self.titleLabel.alpha = 1
                    self.subtitleLabel.alpha = 1
                    self.intensityImageView.alpha = 1
                }
            }
        }

        loadTableData(forSegment: segmentedControl.selectedSegmentIndex, muscle: layerId)
    }
    
    func setOpacityRecursively(node: Node, opacity: Double) {
        if let shape = node as? Shape {
            shape.opacityVar.animation(to: opacity, during: 0.5).play()
        } else if let group = node as? Group {
            for child in group.contents {
                setOpacityRecursively(node: child, opacity: opacity)
            }
        }
    }
    
    func highlightMuscle(_ muscleName: String) {
        guard let body = bodyNode else { return }

        let extraGroups = ["Head", "Feet", "Hands", "Knees"]

        for name in allMuscles.union(extraGroups) {
            let nodesToFade = [name, "\(name) (Stroke)"]

            for nodeName in nodesToFade {
                if let node = body.nodeBy(tag: nodeName) {
                    let targetOpacity: Double
                    if nodeName == muscleName || nodeName == "\(muscleName) (Stroke)" {
                        targetOpacity = 1.0
                    } else {
                        targetOpacity = 0.2
                    }
                    setOpacityRecursively(node: node, opacity: targetOpacity)
                }
            }
        }
    }
    
    func resetMuscleOpacity() {
        guard let body = bodyNode else { return }

        let extraGroups = ["Head", "Feet", "Hands", "Knees"]

        for name in allMuscles.union(extraGroups) {
            let nodesToReset = [name, "\(name) (Stroke)"]

            for nodeName in nodesToReset {
                if let node = body.nodeBy(tag: nodeName) {
                    setOpacityRecursively(node: node, opacity: 1.0)
                }
            }
        }
    }
    
    func applyHighlightMode() {
        guard let body = bodyNode else { return }
        guard let selected = highlightedMuscle else { return }

        let extraGroups = ["Head", "Feet", "Hands", "Knees"]

        for name in allMuscles.union(extraGroups) {
            let nodesToSet = [name, "\(name) (Stroke)"]

            for nodeName in nodesToSet {
                if let node = body.nodeBy(tag: nodeName) {
                    let targetOpacity: Double = (nodeName == selected || nodeName == "\(selected) (Stroke)") ? 1.0 : 0.2
                    setOpacityImmediately(node: node, opacity: targetOpacity)
                }
            }
        }
    }
    
    func setOpacityImmediately(node: Node, opacity: Double) {
        if let shape = node as? Shape {
            shape.opacity = opacity
        } else if let group = node as? Group {
            for child in group.contents {
                setOpacityImmediately(node: child, opacity: opacity)
            }
        }
    }
    
    @objc func segmentChanged() {
        guard let muscle = highlightedMuscle else { return }
        loadTableData(forSegment: segmentedControl.selectedSegmentIndex, muscle: muscle)
    }

    func loadTableData(forSegment index: Int, muscle: String) {
        switch index {
        // Recent Logs
        case 0:
            var results: [WorkoutLogCellModel] = []

            for log in workoutLogs {
                var exercises: [ExerciseSummary] = []

                for exercise in log.exercises {
                    guard exercise.muscles[muscle] != nil else { continue }

                    let setsSummary = exercise.sets
                        .map { "\($0.reps)x\($0.weight)lb" }
                        .joined(separator: ", ")

                    exercises.append(
                        ExerciseSummary(name: exercise.name,
                                        setsSummary: setsSummary)
                    )
                }

                if !exercises.isEmpty {
                    results.append(
                        WorkoutLogCellModel(
                            workoutTitle: log.title,
                            exercises: exercises,
                            isEmptyState: false
                        )
                    )
                }
            }

            if results.isEmpty {
                recentLogItems = [
                    WorkoutLogCellModel(
                        workoutTitle: "No recent logs for this muscle",
                        exercises: [],
                        isEmptyState: true
                    )
                ]
            } else {
                recentLogItems = results
            }
            
        // Recommendations
        case 1:
            let fatigueMap = computeFatiguePerMuscle(from: workoutLogs)
            let fatigue = fatigueMap[muscle] ?? 0
            let intensity = fatigueToLevel(fatigue)

            var filtered = workouts.filter {
                $0.bodyPartsWorked.contains { $0.localizedCaseInsensitiveContains(muscle) }
            }

            if intensity >= 4 {
                filtered.sort { difficultyRank($0.difficulty) < difficultyRank($1.difficulty) }
            } else {
                filtered.sort { difficultyRank($0.difficulty) > difficultyRank($1.difficulty) }
            }
            recommendationItems = filtered
            
        default:
//            tableDataWorkouts = []
            print("ERROR BROKEN")
        }
        tableView.reloadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Ignore touches inside heatMapContainer or detailView
        if touch.view?.isDescendant(of: heatMapContainer) == true { return false }
        if touch.view?.isDescendant(of: detailView) == true { return false }
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        guard isDetailVisible else { return }
        guard let recognizer = sender as? UITapGestureRecognizer else { return }
        let location = recognizer.location(in: view)
        if detailView.frame.contains(location) {
            return
        }
        
        UIView.animate(withDuration: 0.75, animations: {
            self.heatMapContainer.transform = .identity
            self.trailingConstraint?.constant = self.detailViewWidth
            self.view.layoutIfNeeded()
            self.helloLabel.alpha = 1
        })
        
        resetMuscleOpacity()
        isDetailVisible = false
    }
    
    @objc func handleDetailSwipe(_ sender: UISwipeGestureRecognizer) {
        guard isDetailVisible else { return }

        UIView.animate(withDuration: 0.75, animations: {
            self.heatMapContainer.transform = .identity
            self.trailingConstraint?.constant = self.detailViewWidth
            self.view.layoutIfNeeded()
            self.helloLabel.alpha = 1
        })

        resetMuscleOpacity()
        isDetailVisible = false
        highlightedMuscle = nil
    }
    
    func showWelcomeAlert() {
        let message = """
            
            Swipe left/right to rotate the body and view the back
            
            Tap a muscle to see details, recommendations, and recent logs
            
            Once open, swipe the detail panel to the right to close it
            
            Enjoy your training!
            """
        
        let alert = UIAlertController(title: "Welcome to Strata!", message: message, preferredStyle: .alert)
        
        let gotIt = UIAlertAction(title: "Got it", style: .default, handler: nil)
        alert.addAction(gotIt)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        showingFront.toggle()
        let svgName = showingFront ? frontSVG : backSVG
        loadBodySVG(named: svgName)
        attachTapHandlers(view: heatMapContainer)
        fillAllMuscles(front: showingFront)
        
        if highlightedMuscle != nil && isDetailVisible {
            applyHighlightMode()
        }
    }
}
