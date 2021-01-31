//
//  collectionViewCell.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//
import UIKit

class collectionViewCell: UICollectionViewCell, UICollectionViewDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationDistance: UILabel!
    
    func setUp(with display:DisplayListing){
        imageView.image = display.Image
        listingTitle.text = display.Title
        userName.text = display.UserName
        locationDistance.text = display.Location
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //[indexPath.row]

        let display:DisplayListing = displayList[indexPath.item]
        let destinationVC = ShowListingController()
        destinationVC.getEmail = display.Email
        destinationVC.getContent = display.Content
        destinationVC.getTitle = display.Title
        destinationVC.getImage = display.Image
        destinationVC.getLocation = display.Location
        destinationVC.getUsername = display.UserName
        destinationVC.getPhoneNo = display.PhoneNo
            // Let's assume that the segue name is called playerSegue
            // This will perform the segue and pre-load the variable for you to use
        destinationVC.performSegue(withIdentifier: "showListingSegue", sender: self)
    }
    

}
