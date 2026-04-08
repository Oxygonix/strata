//
//  SettingsViewController.swift
//  strata
//
//  Created by Sanjana Madhav on 4/8/26.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let notificationKey = "notificationsEnabled"
    let darkModeKey = "darkModeEnabled"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func darkModeChanged(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.set(isDark, forKey: darkModeKey)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    @IBAction func enableNotifcationsChanged(_ sender: UISwitch) {
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
