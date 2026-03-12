//
//  LoginViewController.swift
//  strata
//
//  Created by Ethan on 3/10/26.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            // Add an alert display to screen showing result in future
            if let error = error as NSError? {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
    
}

