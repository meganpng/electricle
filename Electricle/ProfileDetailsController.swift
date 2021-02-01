//
//  ProfileDetailsController.swift
//  Electricle
//
//  Created by P. Megan on 1/2/21.
//

import Foundation
import UIKit

class ProfileDetailsController: UIViewController{
    let userController:UserController = UserController()
    
    override func viewDidLoad() {
        let email:String = userController.retrieveCurrentEmail()
        let user:User = userController.retrieveUser(currentemail: email)
        //emailLbl.text = user.Email
        //usernameLbl.text = user.userName
        //nameLbl.text = user.Name
        //phonenoLbl.text = user.phoneNo
        super.viewDidLoad()
        
    }
    
    func updateProfileButton(){
        
    }
    
    func changePwd(){
        
    }
    
    func exitBtn(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindFromUpdate( _ seg: UIStoryboardSegue) {
        //emailLbl.reloadData()
        //usernameLbl.reloadData()
        //nameLbl.reloadData()
        //phonenoLbl.reloadData()
    }
}


