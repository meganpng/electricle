//
//  UpdateProfileController.swift
//  Electricle
//
//  Created by P. Megan on 1/2/21.
//

import Foundation
import UIKit
class UpdateProfileController: UIViewController{
    
    let userController:UserController = UserController()
    
    var email:String = ""
    var username:String = ""
    var name:String = ""
    var phoneno:String = ""
    var password:String = ""
    
    
    func update(){
        let alert = UIAlertController(title: "Update Profile?", message: "Are you sure you want to update your profile details?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            let currentemail:String = self.userController.retrieveCurrentEmail()
            let user:User = User(email: self.email, username: self.username, name: self.name, phoneno: self.phoneno, password: self.password)
            
            self.userController.updateProfile(email: currentemail, newUser: user)
            self.userController.updateCurrentProfile(email: currentemail, newUser: user)
            print("Updated " + currentemail)
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
    
    func exit(){
        self.dismiss(animated: true, completion: nil)
    }
}
