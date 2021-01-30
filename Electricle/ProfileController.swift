//
//  ProfileController.swift
//  Electricle
//
//  Created by P. Megan on 29/1/21.
//
import UIKit
import Foundation

class ProfileController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 253)
        collectionView.collectionViewLayout = layout
        collectionView.register(collectionViewCell.nib(), forCellWithReuseIdentifier: collectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}


extension ProfileController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
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
    }
}
