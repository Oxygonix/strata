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
    "Calves": 1,
    "Quads": 5
]

let muscleHeatmapBack: [String: Int] = [
    "Glutes": 4,
    "Hamstrings": 3,
    "Rear Delts": 3,
    "Lats": 5,
    "Triceps": 2,
    "Traps": 3,
    "Forearms": 1,
    "Adductors": 2,
    "Abductors": 2,
    "Calves": 1,
    "Obliques": 3
]

let musclesFront: [String: Int] = [
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

class HeatMapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let db = Firestore.firestore()
    var bodyNode: Node!
    var showingFront = true
    var isDetailVisible = false
    
    var detailView = UIView()
    var trailingConstraint: NSLayoutConstraint?
    let detailViewWidth: CGFloat = 250
    let detailViewHeight: CGFloat = 600
    
    @IBOutlet weak var heatMapLeading: NSLayoutConstraint!
    @IBOutlet weak var heatMapContainer: MacawView!
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        let docRef = db.collection("users").document("\(user!.uid)")
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                let name = document.data()!["name"] as! String
                self.helloLabel.text = "Hello \(name)!"
            } else {
                print("Document does not exist")
            }
        }
        if let tap = view.gestureRecognizers?.first as? UITapGestureRecognizer {
            tap.delegate = self
            tap.cancelsTouchesInView = false
        }
        setupDetailView()
        loadBodySVG(named: "Male-Front")
        attachTapHandlers(view: heatMapContainer)
        fillAllMuscles(front: showingFront)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDark = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        helloLabel.textColor = isDark ? .white : .black
    }
    
    func setupDetailView() {
            // 2. Initialize and style
            detailView.backgroundColor = .red
            detailView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(detailView)

            // 3. Set constraints
            trailingConstraint = detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: detailViewWidth)
            
            NSLayoutConstraint.activate([
                detailView.centerYAnchor.constraint(equalTo: heatMapContainer.centerYAnchor),
                detailView.widthAnchor.constraint(equalToConstant: detailViewWidth),
                detailView.heightAnchor.constraint(equalToConstant: detailViewHeight),
                trailingConstraint!
            ])
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
        print("Handling tap for layer with ID: \(layerId)")
        
        // If already open → just update content
        if isDetailVisible {
            updateView(layerId: layerId)
            return
        }
        
        // First time opening
        let container = self.view!
        let shift = container.frame.width / 2
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75, delay: 0, options: [.curveEaseInOut]) {
            self.heatMapContainer.transform = CGAffineTransform(translationX: -shift, y: 0)
            self.trailingConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        
        isDetailVisible = true
    }
    
    func updateView(layerId: String) {
        // change what details are on the view
        // (name, level of fatigue, recent logs, recommendations)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: heatMapContainer) == true {
            return false
        }
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
        })
        
        isDetailVisible = false
    }

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        showingFront.toggle()
        let svgName = showingFront ? "Male-Front" : "Male-Back"
        loadBodySVG(named: svgName)
        attachTapHandlers(view: heatMapContainer)
        fillAllMuscles(front: showingFront)
    }
}
