//
//  ProfileController.swift
//  Electricle
//
//  Created by P. Megan on 29/1/21.
//
import UIKit
import Foundation

class ProfileController: UIViewController, UICollectionViewDelegate{
    private var spacing = CGFloat()
    
    let userController:UserController = UserController()
    var userEmail:String = ""
    
    var displayList = [DisplayListing]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        //layout.minimumLineSpacing = spacing
        //layout.minimumInteritemSpacing = spacing
        //layout.itemSize = CGSize(width: 200, height: 300)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self //done
        // Added code
        if UIScreen.main.bounds.width <= 375 {
            spacing = 16 // For the iPhone 7, 8, 11 Pro
        } else {
            spacing = 20 // For the iPhone 7+, 8+ and 11 Pro Max
        }
        currentUser = userController.retrieveUser(currentemail: userController.retrieveCurrentEmail())
        displayList = userController.retrieveDisplayListingsByCurrentUser(user: currentUser)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayList = userController.retrieveDisplayListingsByCurrentUser(user: currentUser)
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            ShowListingController, let index =
            collectionView.indexPathsForSelectedItems?.first {
            destination.getListing = displayList[index.row]
            
        }
        
    }
    
    @IBAction func unwindToProfile(_ unwindSegue: UIStoryboardSegue) {
        displayList = userController.retrieveDisplayListingsByCurrentUser(user: currentUser)
        collectionView.reloadData()
    }
  
    @IBAction func logOutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Log Out?", message: "Are you sure you want to log out?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { action in
            let email = self.userController.retrieveCurrentEmail()
            self.userController.deleteCurrentUser(email: email)
            print("Logged out " + email)
            self.performSegue(withIdentifier: "unwindToWelcome", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
         }))

        self.present(alert, animated: true)
        
    }
    
    @IBAction func viewDetailsBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Electricle", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ChangePwdController") as UIViewController
        vc.modalPresentationStyle = .fullScreen //try without fullscreen
        present(vc, animated: true, completion: nil)
    }

}


extension ProfileController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayList.count
    }
    
    /*func numberOfSections(in collectionView: UICollectionView) -> Int {
        let email = userController.retrieveCurrentEmail()
        let currentuser = userController.retrieveUser(currentemail: email)
        let count = userController.retrieveListingCountByCurrentUser(user: currentuser)
        return count
    }*/
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        //cell.configure()
        cell.setUp(with: displayList[indexPath.row])
        cell.displayListing = displayList[indexPath.row]
        return cell
    }
    
    
}


extension ProfileController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let phoneWidth = Int(self.view.frame.width)
        let insets = 40
        let cellsPerRow = 2
        let dividingSpacesInset = (cellsPerRow - 1)*20
        let cellWidth = (phoneWidth-insets-dividingSpacesInset)/cellsPerRow
        return CGSize(width: cellWidth, height: 231)
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

 
