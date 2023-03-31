//
//  LoginViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 11/16/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

      
class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
  
    let userDefault = UserDefaults.standard
    let launchedBefore = UserDefaults.standard.bool(forKey: "userSignedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel?.alpha = 0
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let error = validateFields()
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if error != nil {
            showError(error!)
        } else {
            Auth.auth().signIn(withEmail: email!, password: password!) { result, err in
                if let err = err {
                    self.showError(err.localizedDescription)
                } else {
                   self.userDefault.set(true, forKey: "userSignedIn")
                   self.userDefault.synchronize()
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            self.performSegue(withIdentifier: "loginToHome", sender: nil)
                        }

                    
                }
            }

        }
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" {
            return "Please enter all field"
        }
        return nil
    }
    
    func showError(_ error: String) {
        errorLabel.text? = error
        errorLabel.alpha = 1
    }
 
}
