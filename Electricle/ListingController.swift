//
//  ListingController.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//
import UIKit
import MapKit
import CoreData
import Foundation

class ListingController{
    
    let userController:UserController = UserController()
    /*func AddListingToUser(user:User, message:Message) {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        let m = NSManagedObject(entity: entity, insertInto: context)
        m.setValue(message.Text, forKey: "text")
        m.setValue(message.isSender, forKey: "issender")
        m.setValue(message.Date, forKey: "date")
        
        //This message belongs to a friend
        //Hint: Fetch
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.Name)
        
        do{
            let friendlist = try context.fetch(fetchRequest)
            let f = friendlist[0]
            m.setValue(f, forKey: "friend") //Relationship
        } catch{
            print("Error")
        }
        appDelegate.saveContext()
    }*/
    
    
    func AddListing(listing:Listing){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CDListing", in: context)!
        
        let imageData = listing.Image.pngData()!
        
        
        let item = NSManagedObject(entity: entity, insertInto: context)
        item.setValue(listing.Content, forKey: "content")
        item.setValue(imageData, forKey: "image")
        item.setValue(listing.Location, forKey: "location")
        item.setValue(listing.Title, forKey: "title")

        let email = userController.retrieveCurrentEmail()
        
        //let user = userController.retrieveUser(currentemail: email)
        //var count = userController.retrieveListingCountByCurrentUser(user: user)
        //var count = userController.retrieveListingsByUser(user: user).count
        //count += 1
        
        let id = UUID().uuidString
        item.setValue(id, forKey: "id")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        
        do{
            let userlist = try context.fetch(fetchRequest)
            let u = userlist[0]
            item.setValue(u, forKey:"owner")
        } catch{
            print("Error")
        }
        appDelegate.saveContext()
        
    }
    
    func retriveAllListings() -> [DisplayListing] {
            let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
        
            var userList:[NSManagedObject] = []
            var displayList:[DisplayListing] = []
            
            let allUsers = userController.retrieveAllUser()
            let currentEmail = userController.retrieveCurrentEmail()
            
            for user in allUsers{
                if(user.Email != currentEmail){
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
                }
                }
            
            return displayList
            }
    
    
    func retriveAllListingsBySearch(search:String) -> [DisplayListing] {
           let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           
           let searchResults = search.components(separatedBy: " ")
           
           var userList:[NSManagedObject] = []
           var displayList:[DisplayListing] = []
           
           let allUsers = userController.retrieveAllUser()
           let currentEmail = userController.retrieveCurrentEmail()
           
           for user in allUsers{
               if(user.Email != currentEmail){
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
                               
                               for results in searchResults{
                                   if(Title.contains(results)){
                                       displayList.append(DisplayListing(Title: Title, Content: Content, Image: Image, Location: location, UserName: username, Email: email, PhoneNo: phoneno, Id: id))
                                   }
                                   
                               }
                          
                           }
                       }
                       
                   }
                   catch let error as NSError{
                       print("Could not fetch. \(error), \(error.userInfo)")
                   }
               }
               }
           return displayList
           }

    
    func deleteListing(id:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do{
            let listing = try context.fetch(fetchRequest)
            let deletelisting = listing[0]
            context.delete(deletelisting)
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
