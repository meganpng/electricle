//
//  ChangePwdController.swift
//  Electricle
//
//  Created by P. Megan on 1/2/21.
//

import Foundation
import UIKit
 
class ChangePwdController:UIViewController{
    let userController:UserController = UserController()

    
    var password:String = ""
    
    func changePwd(){
        let alert = UIAlertController(title: "Change Password?", message: "Are you sure you want to change your password?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            let email = self.userController.retrieveCurrentEmail()
            self.userController.changePassword(email: email, password: self.password)
            self.userController.changeCurrentPassword(email: email, password: self.password)
            print("Updated " + self.password)
            //emailLbl.text = ""
            //usernamelbl.text = ""
            //nameLbl.text = ""
            //phoneNoLbl.text = ""
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
         }))

        self.present(alert, animated: true)
        

    }
    
    func exitBtn(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
