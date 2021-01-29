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
    
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let email = emailField.text!
        let pwd = passwordField.text!
        //let emptyBool:Bool = checkFields(email: email, pwd: pwd)
        let flag:Bool = userController.validateUserEmail(input: email)
        let flagtwo:Bool = userController.validateUserPassword(input: pwd)
        if(email == "" && pwd == ""){
            let dialogMessage = UIAlertController(title: "Empty Fields", message: "Please fill up all fields.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else if (flag == false){
            emailField.text = ""
            passwordField.text = ""
            let dialogMessage = UIAlertController(title: "Invalid Email", message: "Please re-enter your email correctly or sign up if you do not have an account.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }
        else if(flagtwo == false){
            passwordField.text = ""
            let dialogMessage = UIAlertController(title: "Invalid Password", message: "Please re-enter your password correctly.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else{// if username and password is correct
            print("\(email), \(pwd)")
            let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Electricle") as UIViewController
            vc.modalPresentationStyle = .fullScreen //try without fullscreen
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    func checkFields(email:String, pwd:String) -> Bool{
        let dataList:[String] = [email, pwd]
        for d in dataList{
            if(d.count == 0){
                return true
            }
        }
        return false
        
    }
    
    @IBAction func onReset(_ sender: Any) {
        emailField.text = ""
        passwordField.text = ""
    }
    
}
