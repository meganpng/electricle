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
    
    
    func AddListing(listing:Listing, user:User){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CDListing", in: context)!
        
        let item = NSManagedObject(entity: entity, insertInto: context)
        item.setValue(listing.Content, forKey: "desc")
        item.setValue(listing.Image, forKey: "image")
        item.setValue(listing.Location, forKey: "location")
        item.setValue(listing.Title, forKey: "title")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchRequest.predicate = NSPredicate(format: "name = %@", user.Name)
        
        
        do{
            let userlist = try context.fetch(fetchRequest)
            let u = userlist[0]
            item.setValue(u, forKey:"owner")
        } catch{
            print("Error")
        }
        appDelegate.saveContext()
    }
    
    func retrieveListingsByUser(user:User) -> [Listing]{
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var userList:[NSManagedObject]=[]
        var listingsList:[Listing]=[]
        
        let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        fetchrequest.predicate = NSPredicate(format: "name = %@", user.Name)
        let fetchListings = NSFetchRequest<NSManagedObject>(entityName: "CDListing")
        
        do{
            userList = try context.fetch(fetchrequest)
            let u = userList[0]
            
            let listings = try context.fetch(fetchListings)
            for l in listings{
                let user = l.value(forKeyPath:"owner")
                if(u == user as! NSObject){
                    let content = l.value(forKeyPath:"desc") as! String
                    let image = l.value(forKeyPath: "image") as! UIImage
                    let location = l.value(forKeyPath: "location") as! String
                    let title = l.value(forKeyPath:"title") as! String
                    listingsList.append(Listing(title: title, content: content, image: image, location: location))
                }
            }
         
            }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return listingsList
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
