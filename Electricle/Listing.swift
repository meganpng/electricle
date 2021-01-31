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
    var Content:String
    var Image:UIImage
    var Location:String
    var Id:String
    init(title:String, content:String, image:UIImage, location:String, id:String) {
        Title = title
        Content = content
        Image = image
        Location = location
        Id = id
    }
}


