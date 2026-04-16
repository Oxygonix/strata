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
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationTitle()
        setupTableView()
        setupProfileHeader()
        setupControls()
        
        // Apply local fallback immediately
        let localDarkMode = UserDefaults.standard.bool(forKey: darkModeKey)
        let localNotifications = UserDefaults.standard.bool(forKey: notificationKey)
        
        darkModeSwitch.isOn = localDarkMode
        notificationSwitch.isOn = localNotifications
        applyDarkMode(isDark: localDarkMode)
        
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
            profileImage.image = savedImage
        }
        
        loadSettingsFromFirestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserProfileLabels()
        loadSettingsFromFirestore()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutStaticCellContents()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 28, right: 0)
        tableView.sectionHeaderHeight = 18
        tableView.sectionFooterHeight = 12
    }
    
    private func setupProfileHeader() {
        profileImage.layer.cornerRadius = 34
        profileImage.layer.cornerCurve = .continuous
        profileImage.clipsToBounds = true
        profileImage.tintColor = .systemRed
        profileImage.backgroundColor = UIColor.systemRed.withAlphaComponent(0.10)
        
        nameLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailLabel.textColor = .secondaryLabel
        emailLabel.numberOfLines = 1
        emailLabel.lineBreakMode = .byTruncatingMiddle
    }
    
    private func setupControls() {
        darkModeSwitch.onTintColor = .systemRed
        notificationSwitch.onTintColor = .systemRed
    }
    
    func updateUserProfileLabels() {
        guard let user = Auth.auth().currentUser else { return }
        let docRef = db.collection("users").document(user.uid)
        
        docRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                let name = data["name"] as? String ?? "No Name"
                let email = user.email ?? "No Email"
                
                DispatchQueue.main.async {
                    self.nameLabel.text = name
                    self.emailLabel.text = email
                }
            } else {
                print("No user document found")
            }
        }
    }
    
    private func loadSettingsFromFirestore() {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("users").document(user.uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to load settings: \(error.localizedDescription)")
                return
            }
            
            guard let data = document?.data() else { return }
            
            let firestoreDarkMode = data["darkModeEnabled"] as? Bool
            let firestoreNotifications = data["notificationsEnabled"] as? Bool
            
            DispatchQueue.main.async {
                if let isDark = firestoreDarkMode {
                    self.darkModeSwitch.isOn = isDark
                    UserDefaults.standard.set(isDark, forKey: self.darkModeKey)
                    self.applyDarkMode(isDark: isDark)
                }
                
                if let notificationsOn = firestoreNotifications {
                    self.notificationSwitch.isOn = notificationsOn
                    UserDefaults.standard.set(notificationsOn, forKey: self.notificationKey)
                }
            }
        }
    }
    
    private func saveSettingsToFirestore(darkMode: Bool? = nil, notifications: Bool? = nil) {
        guard let user = Auth.auth().currentUser else { return }
        
        var updates: [String: Any] = [:]
        
        if let darkMode = darkMode {
            updates["darkModeEnabled"] = darkMode
        }
        
        if let notifications = notifications {
            updates["notificationsEnabled"] = notifications
        }
        
        guard !updates.isEmpty else { return }
        
        db.collection("users").document(user.uid).setData(updates, merge: true) { error in
            if let error = error {
                print("Failed to save settings: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func darkModeChanged(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.set(isDark, forKey: darkModeKey)
        applyDarkMode(isDark: isDark)
        saveSettingsToFirestore(darkMode: isDark)
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
                        self.saveSettingsToFirestore(notifications: true)
                    } else {
                        sender.isOn = false
                        UserDefaults.standard.set(false, forKey: self.notificationKey)
                        self.saveSettingsToFirestore(notifications: false)
                    }
                }
            }
        } else {
            removeDailyNotification()
            saveSettingsToFirestore(notifications: false)
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
        if segue.identifier == "showProfileSettings" {
            if let profileVC = segue.destination as? ProfileSetttingsViewController {
                profileVC.onProfileUpdated = { [weak self] in
                    self?.updateUserProfileLabels()
                }
            }
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    // MARK: - Table sizing
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 132
        }
        
        if indexPath.section == 1 && indexPath.row == 3 {
            return 92
        }
        
        return 88
    }
    
    // MARK: - Card styling
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.clipsToBounds = false
        
        let horizontalInset: CGFloat = 16
        let verticalInset: CGFloat = 8
        let tag = 999
        
        let cardFrame = cell.bounds.inset(by: UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset))
        
        let cardView: UIView
        if let existing = cell.viewWithTag(tag) {
            cardView = existing
            cardView.frame = cardFrame
        } else {
            cardView = UIView(frame: cardFrame)
            cardView.tag = tag
            cardView.isUserInteractionEnabled = false
            cardView.layer.cornerCurve = .continuous
            cell.insertSubview(cardView, at: 0)
        }
        
        cardView.backgroundColor = .secondarySystemGroupedBackground
        cardView.layer.cornerRadius = indexPath.section == 0 ? 30 : 24
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.separator.withAlphaComponent(0.10).cgColor
        
        if indexPath.section == 0 {
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
            cardView.layer.shadowOpacity = 1
            cardView.layer.shadowRadius = 14
            cardView.layer.shadowOffset = CGSize(width: 0, height: 6)
        } else {
            cardView.layer.shadowOpacity = 0
        }
        
        styleCellContents(cell, at: indexPath)
    }
    
    private func styleCellContents(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let labels = cell.contentView.subviews.compactMap { $0 as? UILabel }
        let imageViews = cell.contentView.subviews.compactMap { $0 as? UIImageView }
        let buttons = cell.contentView.subviews.compactMap { $0 as? UIButton }
        
        for label in labels {
            if label == nameLabel {
                label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
                label.textColor = .label
            } else if label == emailLabel {
                label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                label.textColor = .secondaryLabel
            } else {
                label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                label.textColor = .label
                label.lineBreakMode = .byTruncatingTail
            }
        }
        
        for imageView in imageViews {
            if imageView == profileImage {
                continue
            }
            imageView.tintColor = .systemRed
            imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        }
        
        for button in buttons {
            button.setTitleColor(.systemRed, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
    
    // MARK: - Layout fixes for fixed-frame storyboard content
    
    private func layoutStaticCellContents() {
        guard let profileCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)),
              let editCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)),
              let darkCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)),
              let notifCell = tableView.cellForRow(at: IndexPath(row: 2, section: 1)),
              let logoutCell = tableView.cellForRow(at: IndexPath(row: 3, section: 1)) else {
            return
        }
        
        layoutProfileCell(profileCell)
        layoutIconRow(editCell, iconLeading: 34, textLeading: 92)
        layoutSwitchRow(darkCell, labelText: "Dark Mode", toggle: darkModeSwitch)
        layoutSwitchRow(notifCell, labelText: "Enable Notifications", toggle: notificationSwitch)
        layoutLogoutRow(logoutCell)
    }
    
    private func layoutProfileCell(_ cell: UITableViewCell) {
        profileImage.frame = CGRect(x: 32, y: 28, width: 68, height: 68)
        profileImage.layer.cornerRadius = 34
        
        nameLabel.frame = CGRect(x: 120, y: 32, width: cell.bounds.width - 160, height: 28)
        emailLabel.frame = CGRect(x: 120, y: 64, width: cell.bounds.width - 160, height: 24)
    }
    
    private func layoutIconRow(_ cell: UITableViewCell, iconLeading: CGFloat, textLeading: CGFloat) {
        for subview in cell.contentView.subviews {
            if let imageView = subview as? UIImageView {
                imageView.frame = CGRect(x: iconLeading, y: 28, width: 24, height: 24)
            } else if let label = subview as? UILabel {
                label.frame = CGRect(x: textLeading, y: 24, width: cell.bounds.width - textLeading - 40, height: 32)
            }
        }
    }
    
    private func layoutSwitchRow(_ cell: UITableViewCell, labelText: String, toggle: UISwitch) {
        toggle.frame = CGRect(x: 26, y: 26, width: toggle.frame.width, height: toggle.frame.height)
        
        for subview in cell.contentView.subviews {
            if let label = subview as? UILabel {
                label.text = labelText
                label.frame = CGRect(x: 102, y: 24, width: cell.bounds.width - 150, height: 32)
            }
        }
    }
    
    private func layoutLogoutRow(_ cell: UITableViewCell) {
        for subview in cell.contentView.subviews {
            if let button = subview as? UIButton {
                button.frame = CGRect(x: 0, y: 22, width: cell.bounds.width, height: 40)
            }
        }
    }
}
