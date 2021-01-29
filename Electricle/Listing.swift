//
//  Item.swift
//  Electricle
//
//  Created by P. Megan on 28/1/21.
//
import UIKit
import Foundation

class Listing{
    var Title:String
    var Description:String
    var Image:UIImage
    var Location:String
   
    init(title:String, description:String, image:UIImage, location:String) {
        Title = title
        Description = description
        Image = image
        Location = location
    }
}
