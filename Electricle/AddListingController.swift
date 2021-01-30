//
//  AddListingController.swift
//  Electricle
//
//  Created by Mohamed Thabith on 29/1/21.
//

import Foundation
import CoreData
import UIKit

class AddListingController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    
    @IBOutlet weak var AddImgBtn: UIButton!
    
    
    @IBOutlet weak var ListingTitle: UITextField!
    
    @IBOutlet weak var ListingDesc: UITextField!
    
    
    @IBOutlet weak var ListingLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    
    @IBAction func ClickImage(_ sender: Any) {
        let imagepckr = UIImagePickerController()
        imagepckr.sourceType = .photoLibrary
        imagepckr.delegate = self
        imagepckr.allowsEditing = true
        present(imagepckr, animated: true)
    }
    
    
    
    @IBAction func ClickListItem(_ sender: Any) {
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

