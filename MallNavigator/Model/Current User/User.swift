//
//  User.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 10/04/2021.
//

import Foundation
import Firebase

class CurrentUser{
    
    //MARK:- Properties
    static var shared: CurrentUser?
    
    var cart = [Product]()
    var wishlist = [Product]()
    
    var fullName: String
    var phoneNo: String
    var email: String
    
    internal init(user: User) {
        self.fullName = user.displayName ?? ""
        self.phoneNo = user.phoneNumber ?? ""
        self.email = user.email ?? ""
    }
}
