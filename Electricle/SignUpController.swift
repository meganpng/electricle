//
//  SignUpController.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//
import UIKit
import CoreData
import Foundation

class SignUpController: UIViewController{
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var confirmField: UITextField!
    
    let userController:UserController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let email = emailField.text!
        let username = userNameField.text!
        let name = nameField.text!
        let phoneno = phoneField.text!
        let password = passwordField.text!
        let confirmpwd = confirmField.text!

        let emptyBool:Bool = checkFields(email: email, username: username, name: name, phoneno: phoneno, pwd: password, confirmpwd: confirmpwd)
        
        let numberBool:Bool = validatePhoneNumber(phoneno: phoneno)
        
        let flag:Bool = userController.validateUserEmail(input: email)
        if(emptyBool == true){
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
        else if(flag == true){
            emailField.text = ""
            userNameField.text = ""
            nameField.text = ""
            phoneField.text = ""
            passwordField.text = ""
            let dialogMessage = UIAlertController(title: "Email Already Exists", message: "Please log in instead.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        else if(numberBool == true){
            let dialogMessage = UIAlertController(title: "Invalid Number", message: "Please enter valid number.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }

        else if(password != confirmpwd){
            phoneField.text = ""
            passwordField.text = ""
            let dialogMessage = UIAlertController(title: "Passwords Do Not Match", message: "Please enter the same password in the password and confirm password fields.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }


        else{
            print("\(email), \(username), \(name), \(phoneno), \(password)")
            let userobject = User(email: email, username: username, name: name, phoneno: phoneno, password: password)
            let currentobject = CurrentUser(email: email, username: username, name: name, phoneno: phoneno, password: password)
            userController.AddUser(newUser: userobject)
            userController.AddCurrentUser(newCurrentUser: currentobject)
            let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Electricle") as UIViewController
            vc.modalPresentationStyle = .fullScreen //try without fullscreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func onReset(_ sender: Any) {
        emailField.text = ""
        userNameField.text = ""
        nameField.text = ""
        phoneField.text = ""
        passwordField.text = ""
    }
    
    func checkFields(email:String, username:String, name:String, phoneno:String, pwd:String, confirmpwd:String) -> Bool{
        let dataList:[String] = [email, username, name, phoneno, pwd, confirmpwd]
        for d in dataList{
            if(d.count == 0){
                return true
            }
        }
        return false
        
    }
    
    func validatePhoneNumber(phoneno:String) ->Bool{

        let flag:Bool = validateIsNumber(phoneno: phoneno)
        
        if(phoneno.count == 8){
            return false
        }
        else if(flag == true){
            return false
        }
        else if(phoneno.prefix(1) == "6"){
            return false
        }
        else if(phoneno.prefix(1) == "8"){
            return false
        }
        else if(phoneno.prefix(1) == "9"){
            return false
        }
        return true
    }
    
    func validateIsNumber(phoneno:String)->(Bool){
        let charArray = Array(phoneno)
        let numberArray = Array(arrayLiteral: "0", "1", "2","3","4","5","6","7","8","9")
        for c in charArray{
            for n in numberArray{
                if(String(c) != String(n)){
                    return true
                }
            }
        }
        return false
    }
}
