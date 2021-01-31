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
    
    var getListing:DisplayListing = DisplayListing(Title: "", Content: "", Image: UIImage(), Location: "", UserName: "", Email: "", PhoneNo: "")
    
    var getLocation:String = ""
    var getUsername:String = ""
    var getEmail:String = ""
    var getImage:UIImage = UIImage()
    var getContent:String = ""
    var getTitle:String = ""
    var getPhoneNo:String = ""
    
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var contentlbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /*imageView.image = getImage
        titleLbl.text = getTitle
        userNamelbl.text = "From: " + getEmail
        contentlbl.text = getContent
        locationLbl.text = getLocation
        phoneNoLbl.text = getPhoneNo*/
        
        imageView.image = getListing.Image
        titleLbl.text = getListing.Title
        userNamelbl.text = "From: " + getListing.UserName
        contentlbl.text = getListing.Content
        locationLbl.text = getListing.Location
        phoneNoLbl.text = getListing.PhoneNo
    }
    
    
    @IBAction func deleteListing(_ sender: Any) {
        listingController.deleteListing(id: <#T##String#>)
    }
    

    let userController:UserController = UserController()
    
    @IBAction func viewLocationBtn(_ sender: Any) {
        let location:String = locationLbl.text!
        
    }
    

}

