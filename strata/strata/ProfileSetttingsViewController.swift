//
//  ProfileSetttingsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseFirestore

class ProfileSetttingsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightFtTextField: UITextField!
    @IBOutlet weak var heightInTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var benchButton: UIButton!
    @IBOutlet weak var barbellsButton: UIButton!
    @IBOutlet weak var kettlebellButton: UIButton!
    @IBOutlet weak var dumbbellsButton: UIButton!
    @IBOutlet weak var matButton: UIButton!
    @IBOutlet weak var cablesButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    var benchSelected = false
    var barbellsSelected = false
    var kettlebellSelected = false
    var dumbbellsSelected = false
    var matSelected = false
    var cablesSelected = false
    var sex = "male"
    
    var onProfileUpdated: (() -> Void)?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        let docRef = db.collection("users").document("\(user!.uid)")
        
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()!
                
                // Profile info
                let name = data["name"] as? String ?? ""
                self.nameTextField.text = name
                
                let age = data["age"] as? Int ?? 0
                self.ageTextField.text = "\(age)"
                
                if let height = data["height"] as? [String: Any] {
                    let heightFt = height["ft"] as? Int ?? 0
                    let heightIn = height["in"] as? Int ?? 0
                    self.heightFtTextField.text = "\(heightFt)"
                    self.heightInTextField.text = "\(heightIn)"
                }
                
                let weight = data["weight"] as? Int ?? 0
                self.weightTextField.text = "\(weight)"
                
                // Equipment buttons
                if let equipment = data["equipment"] as? [String: Bool] {
                    self.benchSelected = equipment["bench"] ?? false
                    self.barbellsSelected = equipment["barbells"] ?? false
                    self.kettlebellSelected = equipment["kettlebell"] ?? false
                    self.dumbbellsSelected = equipment["dumbbells"] ?? false
                    self.matSelected = equipment["mat"] ?? false
                    self.cablesSelected = equipment["cables"] ?? false
                    
                    // Update button images
                    self.updateEquipmentButtons()
                }
                
                // Sex buttons
                if let savedSex = data["sex"] as? String {
                    self.sex = savedSex
                    self.updateSexButtons()
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func equipmentButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let imageName = sender.isSelected ? "checkmark.square.fill" : "square"
        sender.setImage(UIImage(systemName: imageName), for: .normal)

        switch sender {
        case benchButton:
            benchSelected = sender.isSelected
        case barbellsButton:
            barbellsSelected = sender.isSelected
        case kettlebellButton:
            kettlebellSelected = sender.isSelected
        case dumbbellsButton:
            dumbbellsSelected = sender.isSelected
        case matButton:
            matSelected = sender.isSelected
        case cablesButton:
            cablesSelected = sender.isSelected
        default:
            break
        }
    }
    
    func saveProfileToFirestore() {
        guard let user = Auth.auth().currentUser else {
            return
        }

        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "") ?? 0
        let heightFt = Int(heightFtTextField.text ?? "") ?? 0
        let heightIn = Int(heightInTextField.text ?? "") ?? 0
        let weight = Int(weightTextField.text ?? "") ?? 0

        db.collection("users").document(user.uid).setData([
            "name": name,
            "age": age,
            "height": [
                "ft": heightFt,
                "in": heightIn
            ],
            "sex": sex,
            "weight": weight,
            "equipment": [
                "bench": benchSelected,
                "barbells": barbellsSelected,
                "kettlebell": kettlebellSelected,
                "dumbbells": dumbbellsSelected,
                "mat": matSelected,
                "cables": cablesSelected
            ],
        ], merge: true)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        saveProfileToFirestore()
        // added
        onProfileUpdated?()
        navigationController?.popViewController(animated: true)
        // added
    }
    
    @IBAction func maleButtonPushed(_ sender: Any) {
        sex = "male"
        maleButton.backgroundColor = .red
        femaleButton.backgroundColor = .clear
        maleButton.tintColor = .white
        femaleButton.tintColor = .red
    }
    
    @IBAction func femaleButtonPushed(_ sender: Any) {
        sex = "female"
        femaleButton.backgroundColor = .red
        maleButton.backgroundColor = .clear
        femaleButton.tintColor = .white
        maleButton.tintColor = .red
    }
    
    func updateEquipmentButtons() {
        let equipmentStates = [
            benchButton: benchSelected,
            barbellsButton: barbellsSelected,
            kettlebellButton: kettlebellSelected,
            dumbbellsButton: dumbbellsSelected,
            matButton: matSelected,
            cablesButton: cablesSelected
        ]
        
        for (button, isSelected) in equipmentStates {
            let imageName = isSelected ? "checkmark.square.fill" : "square"
            button?.setImage(UIImage(systemName: imageName), for: .normal)
            button?.isSelected = isSelected
        }
    }

    func updateSexButtons() {
        if sex == "male" {
            maleButton.backgroundColor = .red
            femaleButton.backgroundColor = .clear
            maleButton.tintColor = .white
            femaleButton.tintColor = .red
        } else {
            femaleButton.backgroundColor = .red
            maleButton.backgroundColor = .clear
            femaleButton.tintColor = .white
            maleButton.tintColor = .red
        }
    }
    
}
