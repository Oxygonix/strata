//
//  LoginViewController.swift
//  strata
//
//  Created by Ethan on 3/10/26.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let db = Firestore.firestore()
    private var hasNavigated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            guard let user = user else { return }
            guard !self.hasNavigated else { return }
            
            self.applySavedPreferences(for: user.uid) {
                self.hasNavigated = true
                self.performSegue(withIdentifier: "toHeatmapSegue", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .light
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        overrideUserInterfaceStyle = .unspecified
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Missing Info", message: "Please enter email and password.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
                return
            }
        }
    }
    
    private func applySavedPreferences(for uid: String, completion: @escaping () -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                print("Failed to load preferences: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            
            let data = document?.data() ?? [:]
            
            let isDarkModeEnabled = data["darkModeEnabled"] as? Bool ?? false
            let notificationsEnabled = data["notificationsEnabled"] as? Bool ?? false
            
            UserDefaults.standard.set(isDarkModeEnabled, forKey: "darkModeEnabled")
            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
            
            DispatchQueue.main.async {
                self.applyDarkMode(isDark: isDarkModeEnabled)
                completion()
            }
        }
    }
    
    private func applyDarkMode(isDark: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
