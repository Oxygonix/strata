//
//  HeatMapViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/8/26.
//

import UIKit
import Macaw

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

let singleMusclesFront = ["Chest", "Abs", "Obliques", "Adductors"]

let singleMusclesBack = ["Lats", "Glutes", "Traps", "Adductors"]

class HeatMapViewController: UIViewController {
    
    @IBOutlet weak var heatMapContainer: MacawView!
    
    var bodyNode: Node!
    var showingFront = true
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyNode = try! SVGParser.parse(resource: "Male-Front")
            let macawView = MacawView(node: bodyNode, frame: heatMapContainer.bounds)
            macawView.backgroundColor = .clear
            macawView.contentMode = .scaleAspectFit
            heatMapContainer.addSubview(macawView)
        
        fillAllMuscles(front: showingFront)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDark = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        helloLabel.textColor = isDark ? .white : .black
    }
    
    func fillMuscle(name: String, level: Int) {
        let clampedLevel = max(1, min(level, 10))
        
        guard let color = redHeatmap[clampedLevel] else { return }
        
        var singleFillForView: [String]
            if showingFront {
                singleFillForView = ["Chest", "Abs", "Obliques", "Adductors"]
            } else {
                singleFillForView = ["Lats", "Glutes", "Traps", "Adductors"]
            }
        
        if singleFillForView.contains(name) {
            if let muscleShape = bodyNode.nodeBy(tag: name) as? Shape {
                muscleShape.fill = color
            } else {
                print("Warning: \(name) not found!")
            }
        } else {
            if let muscleGroup = bodyNode.nodeBy(tag: name) as? Group {
                for node in muscleGroup.contents {
                    if let shape = node as? Shape {
                        shape.fill = color
                    }
                }
            } else {
                print("Warning: group \(name) not found!")
            }
        }
    }
    
    func loadBodySVG(named svgName: String) {
        do {
            let node = try SVGParser.parse(resource: svgName)
            bodyNode = node
            
            heatMapContainer.subviews.forEach { $0.removeFromSuperview() }
            
            let macawView = MacawView(node: node, frame: heatMapContainer.bounds)
            macawView.backgroundColor = .clear
            macawView.contentMode = .scaleAspectFit
            
            heatMapContainer.addSubview(macawView)
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
    
    
    @IBAction func muscleTapped(_ sender: UITapGestureRecognizer) {
        // Implement code to highlight the muscle, move the body to the left and lower the opacity for all other muscles.
        // After clicking again, the body should go bacdk to normal
    }

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        showingFront.toggle()
        let svgName = showingFront ? "Male-Front" : "Male-Back"
        loadBodySVG(named: svgName)
        fillAllMuscles(front: showingFront)
    }
}
