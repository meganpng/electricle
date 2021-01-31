//
//  collectionViewCell.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//
import Foundation 
import UIKit

@IBDesignable
class collectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationDistance: UILabel!
    
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
    
    func setUp(with display:DisplayListing){
        imageView.image = display.Image
        listingTitle.text = display.Title
        userName.text = display.UserName
        locationDistance.text = display.Location
    }
    
    /*static let identifier = "collectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with image:UIImage, title:String, username:String, icon:UIImage, distance:String){
        imageView.image = image
        listingTitle.text = title
        userName.text = username
        locationIcon.image = icon
        locationDistance.text = distance
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "collectionViewCell", bundle: nil)
    }*/
}

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
