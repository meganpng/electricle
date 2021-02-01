//
//  HomeController.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//

import Foundation
import UIKit
import CoreData

class HomeController: UIViewController, UICollectionViewDelegate{
    private var spacing = CGFloat()
    
    @IBOutlet weak var ExploreCollectionView: UICollectionView!
    
    
    @IBOutlet weak var search: UITextField!
    
    
    
    let listingController:ListingController = ListingController()
    
    var resultsList=[DisplayListing]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        //layout.minimumLineSpacing = spacing
        //layout.minimumInteritemSpacing = spacing
        //layout.itemSize = CGSize(width: 200, height: 300)
        ExploreCollectionView.collectionViewLayout = layout
        ExploreCollectionView.delegate = self
        ExploreCollectionView.dataSource = self //done
        // Added code
        if UIScreen.main.bounds.width <= 375 {
            spacing = 16 // For the iPhone 7, 8, 11 Pro
        } else {
            spacing = 20 // For the iPhone 7+, 8+ and 11 Pro Max
        }
        resultsList = listingController.retriveAllListings()
        ExploreCollectionView.reloadData()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultsList = listingController.retriveAllListings()
        ExploreCollectionView.reloadData()
    }
    
    
    @IBAction func searchQuery(_ sender: Any) {
        resultsList = listingController.retriveAllListingsBySearch(search:search.text!)
        ExploreCollectionView.reloadData()
     
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as?
//            ShowListingController, let index =
//            collectionView.indexPathsForSelectedItems?.first {
//            destination.getListing = displayList[index.row]
//        }
//    }
    
    
    
}


extension HomeController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Counted: ", resultsList.count)
        return resultsList.count
    }
    
    /*func numberOfSections(in collectionView: UICollectionView) -> Int {
        let email = userController.retrieveCurrentEmail()
        let currentuser = userController.retrieveUser(currentemail: email)
        let count = userController.retrieveListingCountByCurrentUser(user: currentuser)
        return count
    }*/
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        print("method called")
        //cell.configure()
        listingCell.setUpCells(with: resultsList[indexPath.row])
        
        
        return listingCell
    }
    
    
}


extension HomeController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let phoneWidth = Int(self.view.frame.width)
//        let insets = 40
//        let cellsPerRow = 2
//        let dividingSpacesInset = (cellsPerRow - 1)*20
//        let cellWidth = (phoneWidth-insets-dividingSpacesInset)/cellsPerRow
        return CGSize(width: 170, height: 260)
        // Change private let spacing: CGFloat = 20 to


        
        /*let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 2
        let oddEven = indexPath.row / numberOfCellsPerRow % 2
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        if (oddEven == 0) {
            return CGSize(width: dimensions, height: dimensions)
        } else {
            return CGSize(width: dimensions, height: dimensions/2)
        }*/
    
    }

}



