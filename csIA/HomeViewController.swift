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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadHomeScreenLabels() {
        let user = Auth.auth().currentUser
        var uid = ""
        if let id = user?.uid {
            uid = id
        }
        
        db.collection("users").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let name = data["welcome"] as! String
                        let streak = data["streak"] as! Int
                        let totalWorkouts = data["totalWorkouts"] as! Int
                       
                        welcomeLabel?.text = "Welcome " + name
                        
                       streakLabel?.text = "Current Streak " + streak
                        
                        totalWorkoutsLabel?.text = "Total Workouts Compelted " + totalWorkouts
                        
                }
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
