//
//  WorkoutViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 2/7/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class WorkoutViewController: UIViewController {

    @IBOutlet var nameOfWorkoutLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var workoutInfoLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWorkout()
        // Do any additional setup after loading the view.
    }
    
    func displayWorkout(){
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
                            let progress = data["progress"] as! [String:Any]
                            let lastWorkoutClicked = progress["lastWorkoutClicked"] as! Int
                     
                            switch lastWorkoutClicked {
                            case 1:
                                nameOfWorkoutLabel.text? = "Arm Workout"
                                difficultyLabel.text? = "Hard"
                                durationLabel.text? = "10 minutes"
                                workoutInfoLabel.text? = "10 pushups"
                            case 2:
                                nameOfWorkoutLabel.text? = "Leg Workout"
                                difficultyLabel.text? = "Medium"
                                durationLabel.text? = "5 minutes"
                            case 3:
                                nameOfWorkoutLabel.text? = "Leg Workout"
                                difficultyLabel.text? = "Medium"
                                durationLabel.text? = "5 minutes"

                            case 4:
                                nameOfWorkoutLabel.text? = "Leg Workout"
                                difficultyLabel.text? = "Medium"
                                durationLabel.text? = "5 minutes"

                            case 5:
                                nameOfWorkoutLabel.text? = "Leg Workout"
                                difficultyLabel.text? = "Medium"
                                durationLabel.text? = "5 minutes"

                            default:
                                print("Try Again")
                    
                            }
                    }
                }
            }
        }

    
    @IBAction func updateProgress(_ sender: Any) {
        //increase total workouts completed on database
    }

}
