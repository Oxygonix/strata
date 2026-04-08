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

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
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
    
    let notificationKey = "notificationsEnabled"
    let darkModeKey = "darkModeEnabled"
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: darkModeKey)
        UserDefaults.standard.set(false, forKey: notificationKey)
        let isDark = UserDefaults.standard.bool(forKey: darkModeKey)
        darkModeSwitch.isOn = isDark
        
        let notificationsOn = UserDefaults.standard.bool(forKey: notificationKey)
        notificationSwitch.isOn = notificationsOn
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
        
        let user = Auth.auth().currentUser
        let docRef = db.collection("users").document("\(user!.uid)")
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()!
                let name = data["name"] as! String
                self.nameTextField.text = name
                let age = data["age"] as! Int
                self.ageTextField.text = "\(age)"
                if let height = data["height"] as? [String: Any] {
                    let heightFt = height["ft"] as? Int ?? 0
                    let heightIn = height["in"] as? Int ?? 0
                    self.heightFtTextField.text = "\(heightFt)"
                    self.heightInTextField.text = "\(heightIn)"
                }
                let weight = data["weight"] as! Int
                self.weightTextField.text = "\(weight)"
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
    
    @IBAction func darkModeChanged(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.set(isDark, forKey: darkModeKey)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don’t forget to check your workout plan today."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: "dailyReminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Daily notification scheduled")
            }
        }
    }
    
    func removeDailyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
        print("Daily notification removed")
    }
    
    @IBAction func enableNotificationChanged(_ sender: UISwitch) {
        let isOn = sender.isOn
        if isOn {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        UserDefaults.standard.set(true, forKey: self.notificationKey)
                        self.scheduleDailyNotification()
                    } else {
                        sender.isOn = false
                        UserDefaults.standard.set(false, forKey: self.notificationKey)
                    }
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: self.notificationKey)
            removeDailyNotification()
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

        let isDark = darkModeSwitch.isOn
        let notificationsOn = notificationSwitch.isOn

        db.collection("users").document(user.uid).setData([
            "name": name,
            "age": age,
            "height": [
                "ft": heightFt,
                "in": heightIn
            ],
//            "sex": sex,
            "weight": weight,
            "darkModeEnabled": isDark,
            "notificationsEnabled": notificationsOn,
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
    }
    
    @IBAction func logoutButtonPushed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logoutSegue", sender: self)
        } catch {
            print("Error logging out")
        }
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
    
}
