//
//  ViewController.swift
//  strata
//
//  Created by Torres, Ian on 3/5/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    
    var isSigningUp = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let db = Firestore.firestore()
    
    private var hasNavigated = false
    
    override func viewDidLoad() {
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                guard let self = self else { return }
                guard let user = user else { return }
                guard !self.isSigningUp else { return }
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
    
    private func applySavedPreferences(for uid: String, completion: @escaping () -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            let data = document?.data() ?? [:]

            let isDarkModeEnabled = data["darkModeEnabled"] as? Bool ?? false
            let notificationsEnabled = data["notificationsEnabled"] as? Bool ?? false

            UserDefaults.standard.set(isDarkModeEnabled, forKey: "darkModeEnabled")
            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")

            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
                }
                completion()
            }
        }
    }

    @IBAction func createAccountTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Missing Info", message: "Please fill in all fields.")
            return
        }

        guard password == confirmPassword else {
            showAlert(title: "Password Error", message: "Passwords do not match.")
            return
        }
        
        guard password.count >= 6 else {
            showAlert(title: "Password Error", message: "Password must be at least 6 characters long.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(title: "Email Error", message: "Please enter a valid email address.")
            return
        }
        sender.isEnabled = false
        isSigningUp = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            sender.isEnabled = true
            if let error = error {
                self.showAlert(title: "Signup Failed", message: error.localizedDescription)
                return
            }
            guard let user = authResult?.user else {
                self.showAlert(title: "Signup Failed", message: "Could not create user.")
                return
            }
            let userData: [String: Any] = [
                "email": email,
                "createdAt": Timestamp()
            ]
            self.db.collection("users").document(user.uid).setData(userData) { error in
                if let error = error {
                    self.showAlert(title: "Firestore Error", message: error.localizedDescription)
                    return
                }

                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "ProfileSettings", bundle: nil)
                    if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfile") as? ProfileSetttingsViewController {
                        editProfileVC.cameFromSignup = true
                        let navController = UINavigationController(rootViewController: editProfileVC)
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: true)
                    } else {
                        self.showAlert(title: "Navigation Error", message: "Could not open Edit Profile.")
                    }
                }
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
