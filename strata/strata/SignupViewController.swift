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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(title: "Signup Failed", message: error.localizedDescription)
                return
            }

            guard let user = authResult?.user else {
                self.showAlert(title: "Signup Failed", message: "Could not create user.")
                return
            }

            self.db.collection("users").document(user.uid).setData([
                "email": email,
                "createdAt": Timestamp()
            ]) { error in
                if let error = error {
                    self.showAlert(title: "Firestore Error", message: error.localizedDescription)
                } else {
                    self.showAlert(title: "Success", message: "Account created successfully.")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

