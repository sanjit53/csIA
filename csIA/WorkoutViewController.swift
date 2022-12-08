//
//  WorkoutViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 11/16/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
class WorkoutViewController: UIViewController {

    @IBOutlet var workoutTypeTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var durationTextField: UITextField!
    @IBOutlet var addWorkoutButton: UIButton!
    @IBOutlet var editWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editWorkoutLoading()

        // Do any additional setup after loading the view.
    }
    @IBAction func addWorkoutClicked(_ sender: Any) {
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
                        let totalWorkouts = progress["totalWorkouts"] as! Int
//
                        let workoutNumber = totalWorkouts + 1
                        
                        // input all of the data
                        //"workout\(workoutNumber)"
                        let workoutList = data["workoutList"] as! [String:Any]

                }
            }
    }
    
   
    }

    @IBAction func editWorkoutClicked(_ sender: Any) {
        //need to get the workout which you want to
    }
        
    func editWorkoutLoading(){
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
                            let totalWorkouts = progress["totalWorkouts"] as! Int
    //
                            let workoutNumber = totalWorkouts + 1
                            
                            // input all of the data
                            //"workout\(workoutNumber)"
                            let workoutList = data["workoutList"] as! [String:Any]
                            let workout = workoutList["workout\(workoutNumber)"] as! [String:Any]
                            let type = workout["type"] as! String
                            let date = workout["date"] as! String
                            let duration = workout["duration"] as! String

                            workoutTypeTextField.text? = type
                            workoutTypeTextField.text? = date
                            workoutTypeTextField.text? = duration

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
