//
//  SignupViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 11/16/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
 
class SignUpViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
        Utilities.styleFilledButton(nextButton)
    }

    @IBAction func signTapped( _ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            //There was an error
            showError(error!)
        } else {
            //Create cleaned versions of the data
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //There was not an error
            Auth.auth().createUser(withEmail: email!, password: password!) { results, err in
              
                if let err = err {
                    // There was an error
                    self.showError(err.localizedDescription)
                } else {
                    let db = Firestore.firestore()

                    let newDocument = db.collection("users").document()
                    newDocument.setData(["firstName":firstName!, "uid": results!.user.uid,
                            "progress":["streak":1, "totalWorkouts": 0],
                            "workoutList":
                                            ["workout1":["type": "", "date": "", "duration":""]]]) { error in
                    
                    if error != nil {
                        //Shor error message
                        self.showError("Error saving user data ")
                        }
                    }
                }
            }
        }
        performSegue(withIdentifier: "signUpToHome", sender: nil)
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedPassword.count < 8 {
            return "Your password has to be at least 8 characters"
        }
        return nil
    }
    
    func showError(_ error:String){
        errorLabel.text? = error
        errorLabel.alpha = 2
    }
}
