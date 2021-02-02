//
//  ShowListingController.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//

import Foundation
import UIKit

class ShowListingController: UIViewController{
    
    let listingController:ListingController = ListingController()
    
    var getListing:DisplayListing = DisplayListing(Title: "", Content: "", Image: UIImage(), Location: "", UserName: "", Email: "", PhoneNo: "", Id: "")
    
    var getLocation:String = ""
    var getUsername:String = ""
    var getEmail:String = ""
    var getImage:UIImage = UIImage()
    var getContent:String = ""
    var getTitle:String = ""
    var getPhoneNo:String = ""
    var getId:String = ""
    
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var contentlbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //this retrieves data from the listing and displays
        imageView.image = getListing.Image
        titleLbl.text = getListing.Title
        userNamelbl.text = getListing.UserName
        contentlbl.text = getListing.Content
        locationLbl.text = getListing.Location
        phoneNoLbl.text = getListing.PhoneNo
    }
    
    //this deletes the listing
    @IBAction func deleteListing(_ sender: Any) {

        let alert = UIAlertController(title: "Delete Listing?", message: "Are you sure you want to delete your listing?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.listingController.deleteListing(id: self.getListing.Id)
            print("Deleted" + self.getListing.Title)
            self.performSegue(withIdentifier: "unwindToProfile", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
         }))

        self.present(alert, animated: true)

    }
    
    //this redirects the user to the map view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
                    MapViewController{
            destination.getLocationListing = getListing
        }
    }

    //this lets the user exit
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

    let userController:UserController = UserController()
    
    
    @IBAction func viewLocationBtn(_ sender: Any) {
        let location:String = locationLbl.text!
        
    }
    
    
    

}

