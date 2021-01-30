//
//  CurrentUserController.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//
import CoreData
import Foundation
import UIKit

class CurrentUserController{
    
    func AddCurrentUser(newCurrentUser: CurrentUser){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CDCurrentUser", in: context)!
        
        let cuser = NSManagedObject(entity: entity, insertInto: context)
        
        cuser.setValue(newCurrentUser.Email, forKey: "email")
        cuser.setValue(newCurrentUser.userName, forKey:"username")
        cuser.setValue(newCurrentUser.Name, forKey: "name")
        cuser.setValue(newCurrentUser.phoneNo, forKey: "phoneno")
        cuser.setValue(newCurrentUser.Password, forKey: "password")
        
        appDelegate.saveContext()
    }
    
    func retrieveCurrentUser() -> CurrentUser{
        var cuser:[NSManagedObject] = []
        var currentuser:CurrentUser
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDCurrentUser")
        
        do{
            cuser = try context.fetch(fetchRequest)
            
            for cu in cuser{
                let email = cu.value(forKeyPath: "email") as? String
                let username = cu.value(forKeyPath: "username") as? String
                let name = cu.value(forKeyPath: "name") as? String
                let phoneno = cu.value(forKeyPath: "phoneno") as? String
                let password = cu.value(forKeyPath: "password") as? String
                print("\(email!), \(username!), \(name!), \(phoneno!), \(password!)")
                currentuser = CurrentUser(email: email!, username: username!, name: name!, phoneno: phoneno!, password: password!)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return currentuser
    }
    
    func retrieveCurrentEmail() -> String{
        var cuser:[NSManagedObject] = []
        var email:String = ""
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDCurrentUser")
        
        do{
            cuser = try context.fetch(fetchRequest)
            
            for cu in cuser{
                email = (cu.value(forKeyPath: "email") as? String)!
                print("\(email)")
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return email
    }
    
    func deleteCurrentUser(email:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDCurrentUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do{
            let user = try context.fetch(fetchRequest)
            let deleteuser = user[0]
            context.delete(deleteuser)
            //appDelegate.saveContext()
            do{
                try appDelegate.saveContext()
            }
            catch{
                print(error)
            }
        }
        catch let error as NSError{
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
