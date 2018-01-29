//
//  ButtomTextFieldDelegate.swift
//  Meme V1.0
//
//  Created by pu yang on 1/27/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import Foundation
import UIKit

class ButtomTextFieldDelegate : NSObject,UITextFieldDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
