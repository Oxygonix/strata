//
//  SettingsTableViewController.swift
//  strata
//
//  Created by Sanjana Madhav on 4/8/26.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseFirestore

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let darkModeKey = "darkModeEnabled"
    let notificationKey = "notificationsEnabled"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial setup
        applyDarkMode(isDark: UserDefaults.standard.bool(forKey: darkModeKey))
        // Circular image
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true

            // Load saved profile image (example using UserDefaults)
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let savedImage = UIImage(data: imageData) {
                profileImage.image = savedImage
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Always update switches with latest saved values
        darkModeSwitch.isOn = UserDefaults.standard.bool(forKey: darkModeKey)
        notificationSwitch.isOn = UserDefaults.standard.bool(forKey: notificationKey)
        updateUserProfileLabels()
    }
    
    func updateUserProfileLabels() {
        guard let user = Auth.auth().currentUser else { return }
        let docRef = Firestore.firestore().collection("users").document(user.uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                let name = data["name"] as? String ?? "No Name"
                let email = user.email ?? "No Email"
                
                self.nameLabel.text = name
                self.emailLabel.text = email
            } else {
                print("No user document found")
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func darkModeChanged(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.set(isDark, forKey: darkModeKey)
        applyDarkMode(isDark: isDark)
    }
    
    func applyDarkMode(isDark: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    @IBAction func notificationsChanged(_ sender: UISwitch) {
        let isOn = sender.isOn
        UserDefaults.standard.set(isOn, forKey: notificationKey)
        
        if isOn {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        self.scheduleDailyNotification()
                    } else {
                        sender.isOn = false
                        UserDefaults.standard.set(false, forKey: self.notificationKey)
                    }
                }
            }
        } else {
            removeDailyNotification()
        }
    }
    
    // MARK: - Notification Methods
    
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don’t forget to check your workout plan today."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfileSettings" { // <-- your segue identifier from storyboard
            if let profileVC = segue.destination as? ProfileSetttingsViewController {
                profileVC.onProfileUpdated = { [weak self] in
                    self?.updateUserProfileLabels()
                }
            }
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            // Sign the user out
            try Auth.auth().signOut()
            // The segue to the login screen will happen automatically via the storyboard reference
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
