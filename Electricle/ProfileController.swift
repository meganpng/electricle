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
    
    @IBOutlet weak var hiUser: UILabel!
    
    var displayList = [DisplayListing]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //this displays the user's listings and name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self //done

        currentUser = userController.retrieveUser(currentemail: userController.retrieveCurrentEmail())
        displayList = userController.retrieveDisplayListingsByCurrentUser(user: currentUser)
        collectionView.reloadData()
        
        hiUser.text = "Hi, " + currentUser.Name + "!"
    }
    
    //this reloads the user data
    override func viewDidAppear(_ animated: Bool) {
        displayList = userController.retrieveDisplayListingsByCurrentUser(user: currentUser)
        collectionView.reloadData()
        
        hiUser.text = "Hi, " + currentUser.Name + "!"

    }
    
    
    //this redirects the user to the listing details page
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
  
    //this allows the user to log out
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
    
    //this redirects the user to the profile details page
    @IBAction func viewDetailsBtn(_ sender: Any) {
    }

}


extension ProfileController:UICollectionViewDataSource{
    //this sets the number of items in a section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayList.count
    }
    
    //this formats the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        //cell.configure()
        cell.setUp(with: displayList[indexPath.row])
        cell.displayListing = displayList[indexPath.row]
        return cell
    }
    
    
}

//this sets the layout of the cell
extension ProfileController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let phoneWidth = Int(self.view.frame.width)
        let insets = 40
        let cellsPerRow = 2
        let dividingSpacesInset = (cellsPerRow - 1)*20
        let cellWidth = (phoneWidth-insets-dividingSpacesInset)/cellsPerRow
        return CGSize(width: cellWidth, height: 231)
        
    }

}

 
