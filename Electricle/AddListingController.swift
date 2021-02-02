//
//  AddListingController.swift
//  Electricle
//
//  Created by Mohamed Thabith on 29/1/21.
//

import Foundation
import CoreData
import UIKit
import CoreLocation

class AddListingController: UIViewController, UIImagePickerControllerDelegate , CLLocationManagerDelegate, UINavigationControllerDelegate{
    
    let listingController:ListingController = ListingController()
    let userController:UserController = UserController()
    
    
    @IBOutlet weak var AddImgBtn: UIButton!
    
    
    @IBOutlet weak var ListingTitle: UITextField!
    
    @IBOutlet weak var ListingDesc: UITextField!
    
    
    @IBOutlet weak var ListingLocation: UITextField!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddImgBtn.setImage(UIImage(systemName: "plus"), for: .normal)
      
    }
    
    //Opens up Image Picker
    @IBAction func ClickImage(_ sender: Any) {
        let imagepckr = UIImagePickerController()
        imagepckr.sourceType = .photoLibrary
        imagepckr.delegate = self
        imagepckr.allowsEditing = true
        present(imagepckr, animated: true)
    }
    
    
    //Adds Inputted info into CDListing Core Data
    @IBAction func ClickListItem(_ sender: Any) {
        setupLocationManager()
        
        let title = ListingTitle.text!
        let desc = ListingDesc.text!
        let location = ListingLocation.text!
        
        let emptyBool:Bool =
        checkFields(title: title, description: desc, address: location)
    
        //A field is empty
        if(emptyBool == true){
            let dialogMessage = UIAlertController(title: "Empty Fields", message: "Please fill up all fields.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        //All fields have input
        else {
            validateAddress()

        }

    }
    
    //Checks if all fields have input
    func checkFields(title:String, description:String, address:String) -> Bool{
        //If AddImgBtn is '+', an image has not been added
        if (AddImgBtn.currentImage == UIImage(systemName:"plus")){
             return true
            }
        let listing:[String] = [title,description,address]

        for l in listing{
            if(l.count == 0){
               
                return true
                
            }
        }
        
        return false
    }
    
    //sets up location manager functions
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    //Validates the address that the user has inputted
    func validateAddress(){
        let geoCoder = CLGeocoder()
        let image = AddImgBtn.currentImage!
        let title = ListingTitle.text!
        let desc = ListingDesc.text!
        let location = ListingLocation.text!

        geoCoder.geocodeAddressString(location,in:nil,completionHandler:  {(placemarks, error) in
            
            //Location is invalid
            if(error != nil){
               
                print("Status: Invalid Location")
                let dialogMessage = UIAlertController(title: "Invalid Location", message: "Please enter a valid location.", preferredStyle: .alert)
                
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                    
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)
                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
                
            }
            //Location is valid
            if let placemark = placemarks?.first{
                
                print("Status: Location Exists")
                let listingobject = Listing(title: title, content: desc, image: image, location: location, id: "")
                
            
                self.listingController.AddListing(listing: listingobject)
                
                let dialogMessage = UIAlertController(title: "Listed", message: "Your Listing was successful!", preferredStyle: .alert)
                
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                    
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)
                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
                
                //Clears fields
                
                self.AddImgBtn.setImage(UIImage(systemName: "plus"), for: .normal)
                
                self.ListingTitle.text = ""
                self.ListingDesc.text = ""
                self.ListingLocation.text = ""

            }
        
        })
                
        
        }
    
   
    
    
    
     
    //Image picker selection function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        if let image = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage {
            AddImgBtn.setImage(image, for: .normal)
            
        }
                        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    //Cancel image picker function
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

