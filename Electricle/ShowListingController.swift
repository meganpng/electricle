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
    
    @IBOutlet weak var locationLbl: UILabel!
    
    
    
    @IBAction func viewLocationBtn(_ sender: Any) {
        let location:String = locationLbl.text!
        
    }
}

