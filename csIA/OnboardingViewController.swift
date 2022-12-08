//
//  OnboardingViewController.swift
//  csIA
//
//  Created by Sanjit Sathish on 11/16/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(signUpButton)

        // Do any additional setup after loading the view.
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
