//
//  Utilties.swift
//  csIA
//
//  Created by Sanjit Sathish on 12/7/22.
//

import Foundation
import UIKit

class Utilities {
    static func styleFilledButton (_ button:UIButton) {
        button.layer.cornerRadius = 20.0
    }
    
    static func styleHollowButton (_ button:UIButton) {
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.darkGray
    }
    
    static func styleTextField (_ textField: UITextField) {
       // textField.borderColor = UIColor.darkGray.cgColor

    }
    
    static func addTopBorder(_ button:UIButton) {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: button.frame.size.width, height: 1))
            lineView.backgroundColor = UIColor.systemGray6
            button.addSubview(lineView)
        }
    
    static func addBottomBorder (_ button: UIButton) {
        let lineView = UIView(frame: CGRect(x: 0, y: button.frame.size.height, width: button.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.systemGray6
        button.addSubview(lineView)
    }
 }

