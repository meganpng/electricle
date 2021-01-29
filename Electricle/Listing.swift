//
//  Item.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//
import CoreData
import MapKit
import UIKit
import Foundation

class Listing{
    var Title:String
    var Description:String
    var Image:UIImage
    var Location:CLLocation
    var Email:String
    var userName:String
    var phoneNo:String
    init(title:String, description:String, image:UIImage, location:CLLocation, email:String, username:String, phoneno:String) {
        Title = title
        Description = description
        Image = image
        Location = location
    }
}
