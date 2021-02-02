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

    //this redirects the user back to the profile details page
    @IBAction func exitBtn(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToDetailsPwd", sender: self)
    }
    
    @IBOutlet weak var currentFld: UITextField!
    @IBOutlet weak var newFld: UITextField!
    
    //this resets the text fields
    @IBAction func resetBtn(_ sender: Any) {
        currentFld.text! = ""
        newFld.text! = ""
    }
    
    //this allows the password to be changed
    @IBAction func changePwdBtn(_ sender: Any) {
        let email = userController.retrieveCurrentEmail()
        let user = userController.retrieveUser(currentemail: email)
        let currentpwd = currentFld.text!.trimmingCharacters(in: .whitespaces)
        let newpwd = newFld.text!.trimmingCharacters(in: .whitespaces)
        let password = user.Password
        
        //this checks if the current password entered is correct
        if(password == currentpwd){
            let alert = UIAlertController(title: "Change Password?", message: "Are you sure you want to change your password?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in


                
                self.userController.changePassword(currentUser: user, password: newpwd)
                self.userController.changeCurrentPassword(currentUser: user, password: newpwd)
                print("Updated " + newpwd)
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
        //this sends an alert when the current password entered is incorrect
        else{
            let dialogMessage = UIAlertController(title: "Incorrect Current Password", message: "Please re-enter your current password correctly.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    
}
