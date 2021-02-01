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
        let entity = NSEntityDescription.entity(forEntityName: "CDUser", in: context)!
        
        let user = NSManagedObject(entity: entity, insertInto: context)
        
        user.setValue(newUser.Email, forKey: "email")
        user.setValue(newUser.userName, forKey:"username")
        user.setValue(newUser.Name, forKey: "name")
        user.setValue(newUser.phoneNo, forKey: "phoneno")
        user.setValue(newUser.Password, forKey: "password")
        
        appDelegate.saveContext()
    }
    
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
    
    func retrieveCurrentUser(currentemail:String)-> CurrentUser{
        var user:[NSManagedObject] = []
        var currentUser:CurrentUser = CurrentUser(email: "", username: "", name: "", phoneno: "", password: "")
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
                print("\(email!)")
                if(currentemail == email){
                    currentUser = CurrentUser(email: email!, username: username!, name: name!, phoneno: phoneno!, password: password!)
                    break
                }
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return currentUser
    }
    
    func retrieveUser(currentemail:String)-> User{
        var user:[NSManagedObject] = []
        var currentUser:User = User(email: "", username: "", name: "", phoneno: "", password: "")
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
                print("\(email!)")
                if(currentemail == email){
                    currentUser = User(email: email!, username: username!, name: name!, phoneno: phoneno!, password: password!)
                    break
                }
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return currentUser
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
    
    func validateUserPassword(input:String) -> Bool{
        var user:[NSManagedObject] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        
        do{
            user = try context.fetch(fetchRequest)
            
            for u in user{
                let pwd = u.value(forKeyPath: "password") as? String
                print("\(pwd!)")
                if(input == pwd){
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
    
    func updateProfile(email:String, newUser:User){
        //retrieve then set
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do{
            let user = try context.fetch(fetchRequest)
            let userobject = user[0]
  
            //appDelegate.saveContext()
            if(newUser.userName != ""){
                userobject.setValue(newUser.userName, forKey:"username")
            }
            if(newUser.Name != ""){
                userobject.setValue(newUser.Name, forKey: "name")
            }
            if(newUser.phoneNo != ""){
                userobject.setValue(newUser.phoneNo, forKey: "phoneno")
            }
            
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
    
    func updateCurrentProfile(email:String, newUser:User){
        //retrieve then set
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDCurrentUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do{
            let user = try context.fetch(fetchRequest)
            let userobject = user[0]
  
            //appDelegate.saveContext()
            if(newUser.userName != ""){
                userobject.setValue(newUser.userName, forKey:"username")
            }
            if(newUser.Name != ""){
                userobject.setValue(newUser.Name, forKey: "name")
            }
            if(newUser.phoneNo != ""){
                userobject.setValue(newUser.phoneNo, forKey: "phoneno")
            }
            
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
    
    
    func changePassword(email:String, password:String){
        //retrieve then set
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do{
            let user = try context.fetch(fetchRequest)
            let userobject = user[0]
            userobject.setValue(password, forKey: "password")
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
    
    
    
    func changeCurrentPassword(email:String, password:String){
        //retrieve then set
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDCurrentUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        do{
            let user = try context.fetch(fetchRequest)
            let userobject = user[0]
            userobject.setValue(password, forKey: "password")
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
    
    
    func updateCurrentUser(email:String, newUser:User){
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
    
    func retrieveListingsByUser(user:User) -> [Listing] {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        //let m = NSManagedObject(entity: entity, insertInto: context)
        var userList:[NSManagedObject] = []
        var listingList:[Listing] = []
        //This message belongs to a friend
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.Email)
        let fetchUser = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        //fetchMessage.predicate = NSPredicate(format: "isSender = %@", friend.messages!.text!)
        
        do{
            userList = try context.fetch(fetchRequest)
            let u = userList[0]
            //contact = try context.fetch(fetchRequest)
            let listings = try context.fetch(fetchUser)
            for l in listings{
                let user = l.value(forKeyPath: "owner")
                if(user == nil){
                    return listingList
                }
                else if(u == user as! NSObject){
                    let Title = l.value(forKeyPath: "title")  as! String
                    let Content = l.value(forKeyPath: "content") as! String
                    let imgData = l.value(forKeyPath: "image") as! Data
                    let Image:UIImage = UIImage(data: imgData)!
                    let location = l.value(forKeyPath: "location") as! String
                    let id = l.value(forKeyPath: "id") as! String
                    listingList.append(Listing(title: Title, content: Content, image: Image, location: location, id: id))
                }
            }
            
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return listingList
    }
    
    func retrieveListingsByCurrentUser(user:User) -> [Listing] {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        //let m = NSManagedObject(entity: entity, insertInto: context)
        var userList:[NSManagedObject] = []
        var listingList:[Listing] = []
        //This message belongs to a friend
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.Email)
        //let fetchUser = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        //fetchMessage.predicate = NSPredicate(format: "isSender = %@", friend.messages!.text!)
        
        do{
            userList = try context.fetch(fetchRequest)
            let u = userList[0] as! CDUser
            let listings = u.listings!.allObjects as! [CDListing]
            //contact = try context.fetch(fetchRequest)
            for l in listings{
                let user = l.value(forKeyPath: "owner")
                if(user == nil){
                    return listingList
                }
                else if(u == user as! NSObject){
                    let Title = l.value(forKeyPath: "title")  as! String
                    let Content = l.value(forKeyPath: "content") as! String
                    let imgData = l.value(forKeyPath: "image") as! Data
                    let Image:UIImage = UIImage(data: imgData)!
                    let location = l.value(forKeyPath: "location") as! String
                    let id = l.value(forKeyPath: "id") as! String
                    listingList.append(Listing(title: Title, content: Content, image: Image, location: location, id: id))
                }
            }
            
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return listingList
    }
    
    func retrieveDisplayListingsByCurrentUser(user:User) -> [DisplayListing] {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        //let m = NSManagedObject(entity: entity, insertInto: context)
        var userList:[NSManagedObject] = []
        var listingList:[DisplayListing] = []
        //This message belongs to a friend
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.Email)
        //let fetchUser = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        //fetchMessage.predicate = NSPredicate(format: "isSender = %@", friend.messages!.text!)
        let username = user.userName
        let email = user.Email
        let phoneno = user.phoneNo
        
        do{
            userList = try context.fetch(fetchRequest)
            let u = userList[0] as! CDUser
            let listings = u.listings!.allObjects as! [CDListing]
            //contact = try context.fetch(fetchRequest)
            for l in listings{
                let user = l.value(forKeyPath: "owner")
                if(user == nil){
                    return listingList
                }
                else if(u == user as! NSObject){
                    let Title = l.value(forKeyPath: "title")  as! String
                    let Content = l.value(forKeyPath: "content") as! String
                    let imgData = l.value(forKeyPath: "image") as! Data
                    let Image:UIImage = UIImage(data: imgData)!
                    let location = l.value(forKeyPath: "location") as! String
                    let id = l.value(forKeyPath: "id") as! String
                    listingList.append(DisplayListing(Title: Title, Content: Content, Image: Image, Location: location, UserName: username, Email: email, PhoneNo: phoneno, Id: id))
                }
            }
            
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return listingList
    }
    
    
    func retrieveDisplayListingsByUser(user:User) -> [DisplayListing] {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        //let m = NSManagedObject(entity: entity, insertInto: context)
        var userList:[NSManagedObject] = []
        var displayList:[DisplayListing] = []
        //This message belongs to a friend
        let username = user.userName
        let email = user.Email
        let phoneno = user.phoneNo
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.Email)
        let fetchUser = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        //fetchMessage.predicate = NSPredicate(format: "isSender = %@", friend.messages!.text!)
        
        do{
            userList = try context.fetch(fetchRequest)
            let u = userList[0]
            //contact = try context.fetch(fetchRequest)
            let listings = try context.fetch(fetchUser)
            for l in listings{
                let user = l.value(forKeyPath: "owner")
                if(u == user as! NSObject){
                    let Title = l.value(forKeyPath: "title")  as! String
                    let Content = l.value(forKeyPath: "content") as! String
                    let imgData = l.value(forKeyPath: "image") as! Data
                    let Image:UIImage = UIImage(data: imgData)!
                    let location = l.value(forKeyPath: "location") as! String
                    let id = l.value(forKeyPath: "id") as! String
                    displayList.append(DisplayListing(Title: Title, Content: Content, Image: Image, Location: location, UserName: username, Email: email, PhoneNo: phoneno, Id: id))
                }
            }
            
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return displayList
    }

    /*func retrieveListingCountByCurrentUser(user:User) -> Int {
        var count:Int = 0
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        //let m = NSManagedObject(entity: entity, insertInto: context)
        var userList:[NSManagedObject] = []
        //This message belongs to a friend
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", user.Email)
        let fetchUser = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        //fetchMessage.predicate = NSPredicate(format: "isSender = %@", friend.messages!.text!)
        
        do{
            userList = try context.fetch(fetchRequest)
            let u = userList[0]
            //contact = try context.fetch(fetchRequest)
            let listings = try context.fetch(fetchUser)
            for l in listings{
                let user = l.value(forKeyPath: "owner")
                if(u == user as! NSObject){
                    count += 1
                    
                }
            }
            
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return count
    }*/

}

    
    


    

