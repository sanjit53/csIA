//
//  HomeViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 11/16/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var streakLabel: UILabel!
    @IBOutlet var totalWorkoutsLabel: UILabel!
    
    @IBOutlet var addNewWorkoutsButton: UIButton!
    @IBOutlet var searchPastWorkoutsButton: UIButton!
    
    @IBOutlet var searchWorkoutTextField: UITextField!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var searchButton: UIButton!
   
    @IBOutlet var workout1StackView: UIStackView!
    @IBOutlet var workout2StackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadHomeScreenLabels()
        // Do any additional setup after loading the view.
        workout1StackView.alpha = 0
        workout2StackView.alpha = 0
        
        Utilities.styleHollowButton(addNewWorkoutsButton)
        Utilities.styleHollowButton(searchPastWorkoutsButton)
    }
    
    func loadHomeScreenLabels() {
        let user = Auth.auth().currentUser
        var uid = ""
        if let id = user?.uid {
            uid = id
        }
            let db = Firestore.firestore()


        db.collection("users").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let name = data["firstName"] as! String
                        let progress = data["progress"] as! [String:Any]
                        let streak = progress["streak"] as! Int
                        let totalWorkouts = progress["totalWorkouts"] as! Int
                 
                        welcomeLabel?.text = "Welcome " + name + "!"
                        
                       streakLabel?.text = "Current Streak: " + "\(streak)"

                        totalWorkoutsLabel?.text = "Total Workouts Compelted: " +  "\(totalWorkouts)"
                        
                }
            }
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
