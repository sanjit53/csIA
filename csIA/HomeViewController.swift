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
        
    @IBOutlet var viewWorkoutListButton: UIButton!
    @IBOutlet var searchWorkoutTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
   
    @IBOutlet var workout1StackView: UIStackView!
    @IBOutlet var workoutType1: UILabel!
    @IBOutlet var difficulty1Label: UILabel!
    @IBOutlet var duration1Label: UILabel!
    
    
    @IBOutlet var workoutStackView2: UIStackView!
    @IBOutlet var workoutType2Label: UILabel!
    @IBOutlet var difficulty2Label: UILabel!
    @IBOutlet var duration2Label: UILabel!
    
    
    override func viewDidLoad() {
        loadHomeScreenLabels()
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        workout1StackView.alpha = 0
        workoutStackView2.alpha = 0
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
                        let streak = data["streak"] as! Int
                        let totalWorkouts = data["totalWorkouts"] as! Int
                 
                        welcomeLabel?.text = "Welcome " + name + "!"
                        
                       streakLabel?.text = "Current Streak: " + "\(streak)"

                        totalWorkoutsLabel?.text = "Total Workouts Compelted: " +  "\(totalWorkouts)"
                        
                }
            }
        }
    }
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        loadHomeScreenLabels()
    }
    
    @IBAction func searchWorkoutClicked(_ sender: Any) {
        let searchItem:String? = searchWorkoutTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let workoutArray = ["arm","leg","upper", "lower"]
        
        for workout in workoutArray {
            if searchItem == workout {
                generateWorkout(type: searchItem!)
            }
        }
    
        }
    
    @IBAction func searchNavigationButtonClicked(_ sender: Any) {
        if workoutType1.text == "arm" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.performSegue(withIdentifier: "searchToArmWorkout", sender: nil)
            }
        } else if workoutType1.text == "leg" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.performSegue(withIdentifier: "searchToLegWorkout", sender: nil)
            }
        }
    }
    
    
    func generateWorkout(type: String){
        switch type {
        case "arm":
            workout1StackView.alpha = 1
            workoutType1.text = "Arm Workout"
            difficulty1Label.text = "Easy"
            duration1Label.text = "5 Mintues"
            workoutStackView2.alpha = 1
            workoutType1.text = "Arm Workout"
            difficulty1Label.text = "Hard"
            duration1Label.text = "20 Mintues"
        case "leg":
            workout1StackView.alpha = 1
            workoutType1.text = "Leg Workout"
            difficulty1Label.text = "Medium"
            duration1Label.text = "10 Mintues"
            workoutStackView2.alpha = 1
            workoutType1.text = "Leg Workout"
            difficulty1Label.text = "Medium"
            duration1Label.text = "15 Mintues"
        case "abs":
            workout1StackView.alpha = 1
            workoutType1.text = "Abs Workout"
            difficulty1Label.text = "Medium"
            duration1Label.text = "10 Mintues"
        default:
            print("hi")
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
