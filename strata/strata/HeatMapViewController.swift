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

let redHeatmap: [Int: Color] = [
    1: Color.rgb(r: 255, g: 255, b: 255),
    2: Color.rgb(r: 255, g: 230, b: 230),
    3: Color.rgb(r: 255, g: 200, b: 200),
    4: Color.rgb(r: 255, g: 160, b: 160),
    5: Color.rgb(r: 255, g: 100, b: 100)
]

// Sample heatmap data: muscle name -> intensity
let muscleHeatmapFront: [String: Int] = [
    "Chest": 4,
    "Biceps": 3,
    "Shoulders": 3,
    "Traps": 2,
    "Forearms": 1,
    "Abs": 5,
    "Obliques": 3,
    "Adductors": 2,
    "Abductors": 2,
    "Calves": 4,
    "Quads": 5
]

let muscleHeatmapBack: [String: Int] = [
    "Glutes": 4,
    "Hamstrings": 3,
    "Rear Delts": 3,
    "Lats": 5,
    "Triceps": 2,
    "Traps": 2,
    "Forearms": 1,
    "Adductors": 2,
    "Abductors": 2,
    "Calves": 4,
    "Obliques": 3
]

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
    var tableDataWorkouts: [Workout] = []
    
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
        return tableDataWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let workout = tableDataWorkouts[indexPath.row] // we'll define this below
        
        cell.textLabel?.text = workout.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        cell.detailTextLabel?.text = "\(workout.duration) min • \(workout.difficulty)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.detailTextLabel?.textColor = .darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = tableDataWorkouts[indexPath.row]

        let storyboard = UIStoryboard(name: "Recommendations", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "WorkoutDetailViewController") as? WorkoutDetailViewController else { return }
        vc.workout = selectedWorkout

        if let nav = self.navigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            print("No navigation controller found")
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
        // Get "logs" collection from firestore and get the workout logs from the past week to update the heatmaps muscles, and recent logs for the detail view
        // Figure out a way to automatically reduce the intensity based on how long ago the workout was logged
        // It would be like a shade lighter every day i think
    }
    
    func fillMuscle(name: String, level: Int) {
        let clampedLevel = max(1, min(level, 10))
        guard let color = redHeatmap[clampedLevel] else { return }
        let structureMap = showingFront ? musclesFront : musclesBack
        
        guard let isSingleLayer = structureMap[name] else {
                print("Warning: \(name) not defined in structure map")
                return
            }
        
        if isSingleLayer == 1 {
            // Single muscle
            if let shape = bodyNode.nodeBy(tag: name) as? Shape {
                shape.fill = color
            } else {
                print("Warning: shape \(name) not found")
            }
        } else {
            // Separate muscles
            if let group = bodyNode.nodeBy(tag: name) as? Group {
                for node in group.contents {
                    if let shape = node as? Shape {
                        shape.fill = color
                    }
                }
            } else {
                print("Warning: group \(name) not found")
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
        let data = front ? muscleHeatmapFront : muscleHeatmapBack
        for (muscle, intensity) in data {
            fillMuscle(name: muscle, level: intensity)
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
        
        let data = showingFront ? muscleHeatmapFront : muscleHeatmapBack
        let intensity = data[layerId] ?? 1
        
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
            
        case 0:
            // Recent Logs (connect to Firestore later)
            tableDataWorkouts = []
//                "\(muscle) - Log 1",
//                "\(muscle) - Log 2",
//                "\(muscle) - Log 3"
//            ]
            
        case 1:
            // Recommendations
            let data = showingFront ? muscleHeatmapFront : muscleHeatmapBack
            let intensity = data[muscle] ?? 1
            
            var filtered = workouts.filter { workout in
                workout.bodyPartsWorked.contains { $0.localizedCaseInsensitiveContains(muscle) }
            }
            
            if intensity == 5 || intensity == 4 {
                filtered.sort {
                    difficultyRank($0.difficulty) < difficultyRank($1.difficulty)
                }
            } else {
                filtered.sort {
                    difficultyRank($0.difficulty) > difficultyRank($1.difficulty)
                }
            }
            
//            let selected = Array(filtered.prefix(8))
            
            tableDataWorkouts = Array(filtered)
            
        default:
            tableDataWorkouts = []
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
