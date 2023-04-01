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

    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateProgress(_ sender: Any) {
        //increase total workouts completed on database
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let uid = user!.uid
        
        db.collection("users").whereField("uid", isEqualTo: uid)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docId = document.documentID
                        let data = document.data()
                        let streak = data["streak"] as! Int
                        let totalWorkouts = data["totalWorkouts"] as! Int
                        
                        db.collection("users").document(docId).updateData(["streak" : streak+1])
                        db.collection("users").document(docId).updateData(["totalWorkouts" : totalWorkouts+1])
                }
            }
        }
    }
}
