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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //this is the email text field
    @IBOutlet weak var emailField: UITextField!
    
    //this is the password text field
    @IBOutlet weak var passwordField: UITextField!
    
    let userController:UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //this returns the user back to the welcome page when clicked
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        //this gets the text field input
        let email = emailField.text!.trimmingCharacters(in: .whitespaces)
        let pwd = passwordField.text!.trimmingCharacters(in: .whitespaces)

        let flag:Bool = userController.validateUserEmail(input: email)
        let flagtwo:Bool = userController.validateUserPassword(input: pwd)
        
        //this validates the text fields and checks if they're empty and sends an alert
        if(email == "" && pwd == ""){
            let dialogMessage = UIAlertController(title: "Empty Fields", message: "Please fill up all fields.", preferredStyle: .alert)
             
             //this creates the OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //this adds the ok button to the dialog message
             dialogMessage.addAction(ok)
             // this presents the alert
             self.present(dialogMessage, animated: true, completion: nil)
        }
        //this validates if the email is false and sends an alert
        else if (flag == true){
            emailField.text = ""
            passwordField.text = ""
            let dialogMessage = UIAlertController(title: "Invalid Email", message: "Please re-enter your email correctly or sign up if you do not have an account.", preferredStyle: .alert)
            

            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        //this validates if the password is false and sends an alert
        else if(flagtwo == true){
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
            let currentuser:CurrentUser = userController.retrieveCurrentUser(currentemail: email)
            userController.AddCurrentUser(newCurrentUser: currentuser)
            let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Electricle") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            //this redirects user to the home page
            present(vc, animated: true, completion: nil)

        }
        
    }
    
    //this resets the text fields
    @IBAction func onReset(_ sender: Any) {
        emailField.text = ""
        passwordField.text = ""
    }
    
    
}

//this customises the buttons
@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
