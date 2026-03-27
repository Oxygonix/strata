//
//  ViewController.swift
//  strata
//
//  Created by Torres, Ian on 3/5/26.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createAccountTapped(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            // Add an alert display to screen showing result in future
            if let error = error as NSError? {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
}

