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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
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
    
    //this redirects the user back to the home page
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //this submits the sign up details
    @IBAction func onSubmit(_ sender: Any) {
        let email = emailField.text!.trimmingCharacters(in: .whitespaces)
        let username = userNameField.text!.trimmingCharacters(in: .whitespaces)
        let name = nameField.text!.trimmingCharacters(in: .whitespaces)
        let phoneno = phoneField.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordField.text!.trimmingCharacters(in: .whitespaces)
        let confirmpwd = confirmField.text!.trimmingCharacters(in: .whitespaces)

        
        let emptyBool:Bool = checkFields(email: email, username: username, name: name, phoneno: phoneno, pwd: password, confirmpwd: confirmpwd)
        
        
        let numberBool:Bool = validatePhoneNumber(phoneno: phoneno)
        
        let flag:Bool = userController.validateUserEmail(input: email)
        
        //this sends a empty fields alert if the fields are empty
        
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
        
        //this sends an alert if the email entered exists in the database
        else if(flag == false){
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
        //this sends an alert if the number is incorrect
        else if(numberBool == false){
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
        //this sends an alert if the two password fields do not match
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
            //this adds the user and current user to the database and redirects the user to the home page
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
    
    //this resets the fields
    @IBAction func onReset(_ sender: Any) {
        emailField.text = ""
        userNameField.text = ""
        nameField.text = ""
        phoneField.text = ""
        passwordField.text = ""
        confirmField.text = ""
    }
    
    //this checks if the fields are empty
    func checkFields(email:String, username:String, name:String, phoneno:String, pwd:String, confirmpwd:String) -> Bool{
        let dataList:[String] = [email, username, name, phoneno, pwd, confirmpwd]
        for d in dataList{
            if(d.count == 0){
                return true
            }
        }
        return false
        
    }
    
    
    //this validates the phone number
    func validatePhoneNumber(phoneno:String) ->Bool{

        let flag:Bool = validateIsNumber(phoneno: phoneno)
        
        if(phoneno.count != 8){
            return false
        }
        else if(flag == false){
            return false
        }
        else if(phoneno.prefix(1) != "6" && phoneno.prefix(1) != "8" && phoneno.prefix(1) != "9"){
            return false
        }
        return true
    }
    
    //this checks if letters were entered
    func validateIsNumber(phoneno:String)->(Bool){
        let charArray: Array<Character> = Array(phoneno)
        for char in charArray {
            if Int(String(char)) == nil {
                return false
            }
        }
        return true
        /*
        let charArray:Array<Character> = Array(phoneno)
        let numberArray:Array<Character> = Array(arrayLiteral: "0", "1", "2","3","4","5","6","7","8","9")
        var flag:Bool = false
        for c in charArray{
            var bool:Bool = false
            for n in numberArray{
                if(c == n){
                    bool = true
                    break
                }
            }
            if(bool == true){
                flag = true
            }
            else{
                flag = false
            }
        }
        if(flag == true){
            return true
        }
        else{
            return false
        }
 */
    }
}
