//
//  User.swift
//  Electricle
//
//  Created by P. Megan on 27/1/21.
//

import Foundation
import UIKit

class User{
    var userName:String
    var Name:String
    var Email:String
    var Password:String
    var phoneNo:String

    init(email:String, username:String, name:String, phoneno: String, password:String ) {
        Email = email
        userName = username
        Name = name
        phoneNo = phoneno
        Password = password

    }
}
