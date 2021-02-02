//
//  ShowSelectedListingController.swift
//  Electricle
//
//  Created by Mohamed Thabith on 1/2/21.
//

import Foundation
import UIKit

class ShowSelectedListingController: UIViewController{
    
    
    var getListing:DisplayListing = DisplayListing(Title: "", Content: "", Image: UIImage(), Location: "", UserName: "", Email: "", PhoneNo: "", Id: "")
    
    var getLocation:String = ""
    var getUsername:String = ""
    var getEmail:String = ""
    var getImage:UIImage = UIImage()
    var getContent:String = ""
    var getTitle:String = ""
    var getPhoneNo:String = ""
    var getId:String = ""
    
    
    @IBOutlet weak var listingImage: UIImageView!
    
    @IBOutlet weak var listingTitle: UILabel!
    
    @IBOutlet weak var listingUser: UILabel!
    
    
    @IBOutlet weak var listingDesc: UILabel!
    
    
    @IBOutlet weak var listingNumber: UILabel!
    
    @IBOutlet weak var listingLocation: UILabel!
    
    //Sets up the layout
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listingImage.image = getListing.Image
        
        listingTitle.text = getListing.Title
        
        listingUser.text = "@" + getListing.UserName
        
        listingDesc.text = getListing.Content
        
        listingLocation.text = getListing.Location
        
        listingNumber.text = getListing.PhoneNo
        
        
    }
    
    
    
    //Segue to MapViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
                    MapViewController{
            destination.getLocationListing = getListing
        }
    }
    
    
    
    //Dismiss the listing and return to HomeController
    @IBAction func dismissListing(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    
}
