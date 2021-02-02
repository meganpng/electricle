//
//  collectionViewCell.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//
import UIKit

@IBDesignable
class collectionViewCell: UICollectionViewCell, UICollectionViewDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationDistance: UILabel!
    
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
    
    //this sets up the listing cell
    func setUp(with display:DisplayListing){
        imageView.image = display.Image
        listingTitle.text = display.Title
        userName.text = display.UserName
        locationDistance.text = display.Location
    }
    
    //this opens the listing details when the cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//this segues the user to the listing details
        let display:DisplayListing = displayListing!
        let destinationVC = ShowListingController()
        destinationVC.getEmail = display.Email
        destinationVC.getContent = display.Content
        destinationVC.getTitle = display.Title
        destinationVC.getImage = display.Image
        destinationVC.getLocation = display.Location
        destinationVC.getUsername = display.UserName
        destinationVC.getPhoneNo = display.PhoneNo
        destinationVC.getId = display.Id

        destinationVC.performSegue(withIdentifier: "showListingSegue", sender: self)
    }
    

}

//this customises the cell
@IBDesignable
class collectionViewCellImage:UIImageView{
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
}
