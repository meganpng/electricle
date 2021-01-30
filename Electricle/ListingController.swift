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
