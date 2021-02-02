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
        
        //'Cancel Search' button is hidden
        cancelBtn.isHidden = true
        
        //CollectionCell is set up
        
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
    
    //reload collectionCell again
    override func viewDidAppear(_ animated: Bool) {
        resultsList = listingController.retriveAllListings()
        ExploreCollectionView.reloadData()
    }
    
    //CollectionCell only contains results which match the search
    @IBAction func searchQuery(_ sender: Any) {
        
        //Only search in searchfield is not blank
        if(search.text != ""){
            cancelBtn.isHidden = false
            
            resultsList = listingController.retriveAllListingsBySearch(search:search.text!)
            ExploreCollectionView.reloadData()
        }
        //if search field is empty reload normal layout
        else{
            
            cancelBtn.isHidden = true

            resultsList = listingController.retriveAllListings()
            ExploreCollectionView.reloadData()
        }
        
       
     
    }
    
    //User cancels search to return to normal layout where all listings are shown
    @IBAction func cancelSearching(_ sender: Any) {
        resultsList = listingController.retriveAllListings()
        ExploreCollectionView.reloadData()
        
        search.text = ""
        
        cancelBtn.isHidden = true

    }
    
    //Segue to ShowSelected Listing Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            ShowSelectedListingController, let index =
            ExploreCollectionView.indexPathsForSelectedItems?.first {
            destination.getListing = resultsList[index.row]
        }
    }
    
    
    
}


extension HomeController:UICollectionViewDataSource{
    
    //Counts number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Counted: ", resultsList.count)
        return resultsList.count
    }
    
  
    //Calls function to configures cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        //cell.configure()
        listingCell.setUpCells(with: resultsList[indexPath.row])
        
        
        return listingCell
    }
    
    
}


extension HomeController:UICollectionViewDelegateFlowLayout{
    
    //sets up cells layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 170, height: 260)
       


  
    }

}



