//
//  HomeCollectionViewCell.swift
//  Electricle
//
//  Created by Mohamed Thabith on 31/1/21.
//

import Foundation
import UIKit

@IBDesignable
class HomeCollectionViewCell:UICollectionViewCell, UICollectionViewDelegate{
    
    
    @IBOutlet weak var listingImage: UIImageView!
    
    
    @IBOutlet weak var listingTitle: UILabel!
    
    
    @IBOutlet weak var listingUser: UILabel!
    
    @IBOutlet weak var listingLocation: UILabel!
    
    var displayListing: DisplayListing?

    
    @IBInspectable var cornerRadius: CGFloat = 0{
            didSet{
                self.layer.cornerRadius = cornerRadius
            }
        }

        @IBInspectable var borderColor: UIColor = UIColor.clear{
            didSet{
                self.layer.borderColor = borderColor.cgColor
            }
        }

        @IBInspectable var borderWidth: CGFloat = 0{
            didSet{
                self.layer.borderWidth = borderWidth
            }
        }

    func setUpCells(with display:DisplayListing){
        
        
        listingImage.image = display.Image
        listingTitle.text = display.Title 
        listingUser.text = display.UserName
        listingLocation.text = display.Location
        
        print(listingTitle.text, " ", listingLocation )

        
    }
    

    

}
