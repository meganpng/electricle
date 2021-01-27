//
//  UserController.swift
//  Electricle
//
//  Created by P. Megan on 27/1/21.
//
import CoreData
import Foundation
import UIKit

class UserController{
    func AddUser(newUser: User){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        
        let user = NSManagedObject(entity: entity, insertInto: context)
        
        user.setValue(newUser.userName, forKey:"username")
        user.setValue(newUser.Email, forKey: "email")
        user.setValue(newUser.Password, forKey: "password")
        
        appDelegate.saveContext()
    }
    
    func retrieveAllUser()->[User]{
        var user:[NSManagedObject] = []
        var userList:[User] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        
        do{
            user = try context.fetch(fetchRequest)
            
            for u in user{
                let username = u.value(forKeyPath: "username") as? String
                let email = u.value(forKeyPath: "email") as? String
                let password = u.value(forKeyPath: "password") as? String
                print("\(username!), \(email!), \(password!)")
                userList.append(User(username: username!, email: email!, password: password!))
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return userList
    }
    
    func updateUser(email:String, newUser:User){
        //retrieve then set
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do{
            let user = try context.fetch(fetchRequest)
            let userobject = user[0]
            userobject.setValue(newUser.userName, forKey:"username")
            userobject.setValue(newUser.Email, forKey: "email")
            userobject.setValue(newUser.Password, forKey: "password")
            //appDelegate.saveContext()
            do{
                try context.save()
                //try appDelegate.saveContext()
            }
            catch let error as NSError{
                //print(error)
                print("Could not update. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not update. \(error), \(error.userInfo)")
        }
        

    }
    
    func deleteUser(email:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
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


    
    


    

