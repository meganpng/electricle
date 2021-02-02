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

    var username:String = ""
    var name:String = ""
    var phoneno:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBOutlet weak var usernameFld: UITextField!
    
    @IBOutlet weak var nameFld: UITextField!
    
    @IBOutlet var phoneNoFld: UITextField!
    
    //this resets the text fields
    @IBAction func resetBtn(_ sender: Any) {
        usernameFld.text! = ""
        nameFld.text! = ""
        phoneNoFld.text! = ""
        
    }
    
  
    
    //this edits the profile details
    @IBAction func editProfileBtn(_ sender: Any) {
      
        let alert = UIAlertController(title: "Update Profile?", message: "Are you sure you want to update your profile details?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            let currentemail:String = self.userController.retrieveCurrentEmail()
            let currentuser:User = self.userController.retrieveUser(currentemail: email)
            let user:User = User(email: currentemail, username: self.usernameFld.text!.trimmingCharacters(in: .whitespaces) , name: self.nameFld.text!.trimmingCharacters(in: .whitespaces) , phoneno: self.phoneNoFld.text!.trimmingCharacters(in: .whitespaces) , password: currentuser.Password)
            
            self.userController.updateProfile(email: currentemail, newUser: user)
            self.userController.updateCurrentProfile(email: currentemail, newUser: user)
            print("Updated " + currentemail)
            self.usernameFld.text = ""
            self.nameFld.text = ""
            self.phoneNoFld.text = ""
            //nameLbl.text = ""
            //phoneNoLbl.text = ""
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
         }))

        self.present(alert, animated: true)
    }
    
    
    //this lets the user exit
    @IBAction func exitButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToProfileDetailsUpdate", sender: self)
        //self.dismiss(animated: true, completion: nil)
    }
}
