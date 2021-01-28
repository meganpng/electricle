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
        
        user.setValue(newUser.Email, forKey: "email")
        user.setValue(newUser.userName, forKey:"username")
        user.setValue(newUser.Name, forKey: "name")
        user.setValue(newUser.phoneNo, forKey: "phoneno")
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
                let email = u.value(forKeyPath: "email") as? String
                let username = u.value(forKeyPath: "username") as? String
                let name = u.value(forKeyPath: "name") as? String
                let phoneno = u.value(forKeyPath: "phoneno") as? String
                let password = u.value(forKeyPath: "password") as? String
                print("\(email!), \(username!), \(name!), \(phoneno!), \(password!)")
                userList.append(User(email: email!, username: username!, name: name!, phoneno: phoneno!, password: password!))
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return userList
    }
    
    func retrieveAllEmail()->[String]{
        var user:[NSManagedObject] = []
        var userList:[String] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        
        do{
            user = try context.fetch(fetchRequest)
            
            for u in user{
                let email = u.value(forKeyPath: "email") as? String
                print("\(email!)")
                userList.append(email!)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return userList
    }
    
    func validateUserEmail(input:String) -> Bool{
        var user:[NSManagedObject] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        
        do{
            user = try context.fetch(fetchRequest)
            
            for u in user{
                let email = u.value(forKeyPath: "email") as? String
                print("\(email!)")
                if(input == email){
                    return true
                }
            }

        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return false
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
            userobject.setValue(newUser.Email, forKey: "email")
            userobject.setValue(newUser.userName, forKey:"username")
            userobject.setValue(newUser.Name, forKey: "name")
            userobject.setValue(newUser.phoneNo, forKey: "phoneno")
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


    
    


    

