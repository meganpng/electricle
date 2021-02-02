//
//  HomeController.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//

import Foundation
import UIKit
import CoreData

class HomeController: UIViewController, UICollectionViewDelegate, CLLocationManagerDelegate{
    private var spacing = CGFloat()
    
    
    
    @IBOutlet weak var ExploreCollectionView: UICollectionView!
    
    
    @IBOutlet weak var search: UITextField!
    
    
    @IBOutlet weak var cancelBtn: RoundButton!
    
    let listingController:ListingController = ListingController()
    
    var resultsList=[DisplayListing]()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelBtn.isHidden = true
        
        let layout = UICollectionViewFlowLayout()
       
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
        
        cancelBtn.isHidden = false
        
        resultsList = listingController.retriveAllListingsBySearch(search:search.text!)
        ExploreCollectionView.reloadData()
     
    }
    
    
    @IBAction func cancelSearching(_ sender: Any) {
        resultsList = listingController.retriveAllListings()
        ExploreCollectionView.reloadData()
        
        search.text = ""
        
        cancelBtn.isHidden = true

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            ShowSelectedListingController, let index =
            ExploreCollectionView.indexPathsForSelectedItems?.first {
            destination.getListing = resultsList[index.row]
        }
    }
    
    
    
}


extension HomeController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Counted: ", resultsList.count)
        return resultsList.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        //cell.configure()
        listingCell.setUpCells(with: resultsList[indexPath.row])
        
        
        return listingCell
    }
    
    
}


extension HomeController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 170, height: 260)
       


  
    }

}



