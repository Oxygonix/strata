//
//  ProfileSetttingsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit
import UserNotifications

class ProfileSetttingsViewController: UIViewController {

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    let notificationKey = "notificationsEnabled"
    let darkModeKey = "darkModeEnabled"
    override func viewDidLoad() {
        super.viewDidLoad()

        let isDark = UserDefaults.standard.bool(forKey: darkModeKey)
        darkModeSwitch.isOn = isDark
        
        let notificationsOn = UserDefaults.standard.bool(forKey: notificationKey)
        notificationSwitch.isOn = notificationsOn
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    @IBAction func equipmentButton(_ sender: UIButton) {
        sender.isSelected.toggle()

            if sender.isSelected {
                sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "square"), for: .normal)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
