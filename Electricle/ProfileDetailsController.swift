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
    
    
    @IBOutlet var detailsView: UIView!
    @IBOutlet weak var emailLbl: UILabel!

    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var phonenoLbl: UILabel!
    
    //this redirects the user to the edit profile page
    @IBAction func editProfileBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UpdateProfileController") as UIViewController
        vc.modalPresentationStyle = .fullScreen //try without fullscreen
        present(vc, animated: true, completion: nil)
    }
    
    //this redirects the user to change password page
    @IBAction func changePwdBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ChangePwdController") as UIViewController
        vc.modalPresentationStyle = .fullScreen //try without fullscreen
        present(vc, animated: true, completion: nil)
    }
    
    //this lets the user exit
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //this loads the information onto the page to be displayed
    override func viewDidLoad() {
        let email:String = userController.retrieveCurrentEmail()
        let user:User = userController.retrieveUser(currentemail: email)
        emailLbl.text! = user.Email
        usernameLbl.text! = user.userName
        nameLbl.text = user.Name
        phonenoLbl.text = user.phoneNo
        super.viewDidLoad()
        
    }
    
    //this reloads the data when the user is redirected from the edit profile page
    @IBAction func unwindFromUpdate( _ seg: UIStoryboardSegue) {
        let email:String = userController.retrieveCurrentEmail()
        let user:User = userController.retrieveUser(currentemail: email)
        emailLbl.text! = user.Email
        usernameLbl.text! = user.userName
        nameLbl.text = user.Name
        phonenoLbl.text = user.phoneNo
    }
    
    //this reloads the data when the user is redirected from the change password page
    @IBAction func unwindFromPwd( _ seg: UIStoryboardSegue) {
        //emailLbl.reloadData()
        //usernameLbl.reloadData()
        //nameLbl.reloadData()
        //phonenoLbl.reloadData()
        let email:String = userController.retrieveCurrentEmail()
        let user:User = userController.retrieveUser(currentemail: email)
        emailLbl.text! = user.Email
        usernameLbl.text! = user.userName
        nameLbl.text = user.Name
        phonenoLbl.text = user.phoneNo
    }
    
}


