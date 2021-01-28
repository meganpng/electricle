//
//  LoginController.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//
import CoreData
import UIKit
import Foundation
class LoginController: UIViewController{
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    let userController:UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func onSubmit(_ sender: Any) {
        let email = emailField.text!
        let flag:Bool = userController.validateUserEmail(input: email)
        
        if flag{ // if username and password is correct
            let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen //try without fullscreen
            present(vc, animated: true, completion: nil)
        }
        else{
            
        }
    }
    
}
