//
//  ShowListingController.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//

import Foundation
import UIKit

class ShowListingController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let userController:UserController = UserController()
    
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet var imageView: UIView!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var contentlbl: UILabel!
    
    var getLocation:String = ""
    var getUsername:String = ""
    var getEmail:String = ""
    var getImage:UIImage = UIImage()
    var getContent:String = ""
    var getTitle:String = ""
    var getPhoneNo:String = ""
    
    
    @IBAction func viewLocationBtn(_ sender: Any) {
        let location:String = locationLbl.text!
        
    }
    

}

