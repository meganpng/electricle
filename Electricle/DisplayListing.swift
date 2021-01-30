//
//  DisplayListing.swift
//  Electricle
//
//  Created by P. Megan on 30/1/21.
//

import Foundation
import UIKit


struct DisplayListing{
    let Title:String
    let Content:String
    let Image:UIImage
    let Location:String
    let UserName:String
}

let userController:UserController = UserController()
var email:String = userController.retrieveCurrentEmail()

var currentUser = userController.retrieveUser(currentemail: email)

let displayList:[DisplayListing] = userController.retrieveDisplayListingsByUser(user: currentUser)
