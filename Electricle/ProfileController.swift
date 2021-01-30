//
//  ProfileController.swift
//  Electricle
//
//  Created by P. Megan on 29/1/21.
//
import UIKit
import Foundation

class ProfileController: UIViewController{
    private var spacing = CGFloat()
    
    let userController:UserController = UserController()
    var userEmail:String = "";
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: 165, height: 253)
        collectionView.collectionViewLayout = layout
        collectionView.register(collectionViewCell.nib(), forCellWithReuseIdentifier: collectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        // Added code
        if UIScreen.main.bounds.width <= 375 {
            spacing = 16 // For the iPhone 7, 8, 11 Pro
        } else {
            spacing = 20 // For the iPhone 7+, 8+ and 11 Pro Max
        }
    }
    
}


extension ProfileController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell.identifier, for: indexPath) as! collectionViewCell
        
        //cell.configure()
        
        return cell
    }
}


extension ProfileController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 253)
        // Change private let spacing: CGFloat = 20 to


        
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 2
        let oddEven = indexPath.row / numberOfCellsPerRow % 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        /*if (oddEven == 0) {
            return CGSize(dimensions, dimensions)
        } else {
            return CGSizeMake(dimensions, dimensions / 2)
        }*/
    
    }

}
