//
//  WorkoutListViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 2/7/23.
//

import UIKit

class WorkoutListViewController: UIViewController {

    @IBOutlet var workout1Button: UIButton!
    @IBOutlet var workout2Button: UIButton!
    @IBOutlet var workout3Button: UIButton!
    @IBOutlet var workout4Button: UIButton!
    @IBOutlet var workout5Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func workoutClicked(_ sender: UIButton
    ) {
    //update database which says workout #1 clicked
       var buttonClicked = 0
        switch sender {
        case workout1Button:
            buttonClicked = 1
        case workout2Button:
            buttonClicked = 2
        default:
            print("Try Again")
        }
        //updaate data base
        
    }
    
    
}
