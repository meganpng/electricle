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

class AddListingController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    let listingController:ListingController = ListingController()
    let userController:UserController = UserController()
    @IBOutlet weak var AddImgBtn: UIButton!
    
    
    @IBOutlet weak var ListingTitle: UITextField!
    
    @IBOutlet weak var ListingDesc: UITextField!
    
    
    @IBOutlet weak var ListingLocation: UITextField!
    
    let locationManager = CLLocationManager()
    
    var latitude = 1.0
    
    var longitude = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddImgBtn.setImage(UIImage(systemName: "plus"), for: .normal)
      
    }
    
    
    @IBAction func ClickImage(_ sender: Any) {
        let imagepckr = UIImagePickerController()
        imagepckr.sourceType = .photoLibrary
        imagepckr.delegate = self
        imagepckr.allowsEditing = true
        present(imagepckr, animated: true)
    }
    
    
    
    @IBAction func ClickListItem(_ sender: Any) {
        setupLocationManager()
        
       

        
        let image = AddImgBtn.currentImage!
        let title = ListingTitle.text!
        let desc = ListingDesc.text!
        let location = ListingLocation.text!
        validateAddress(address: location)
        
        let emptyBool:Bool =
        checkFields(title: title, description: desc, address: location)
    
        
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
        
        else if(latitude==0.0 && longitude == 0.0){
            self.latitude = 1.0
            self.longitude = 1.0
           
            
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
        
        else{
            
            
            let listingobject = Listing(title: title, content: desc, image: image, location: location)
            
            listingController.AddListing(listing: listingobject)
            
            AddImgBtn.setImage(UIImage(systemName: "plus"), for: .normal)
            
            ListingTitle.text = ""
            ListingDesc.text = ""
            ListingLocation.text = ""
            
        }
        

    }
    
    
    func checkFields(title:String, description:String, address:String) -> Bool{
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
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func validateAddress(address:String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address, completionHandler: {(placemarks, error) in
            
            if(error != nil){
                print("Error: \(error)")
                self.latitude = 0.0
                self.longitude = 0.0
            }
        
        })
        
        }
    
   
    
    
    
     
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        if let image = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage {
            AddImgBtn.setImage(image, for: .normal)
            
        }
                        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

