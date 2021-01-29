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
   
    init(title:String, description:String, image:UIImage, location:CLLocation) {
        Title = title
        Description = description
        Image = image
        Location = location
    }
}
