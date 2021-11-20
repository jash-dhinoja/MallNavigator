//
//  EventHolder.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 02/04/2021.
//

import Foundation

struct EventHolder {
    
    var name: String
    var contactNo: String
    var email: String
    
    init(name: String, contactNo: String, email: String) {
        self.name = name
        self.contactNo = contactNo
        self.email = email
    }
    
    init?(dict: [String: Any]){
        guard let name = dict["name"] as? String,
              let contactNo = dict["contactNo"] as? String,
              let email = dict["email"] as? String else { return nil}
        
        self.init(name: name,
                  contactNo: contactNo,
                  email: email)
        
    }
    
    var dictionary: [String: Any]{
        return [
            "name" : name,
            "contactNo" : contactNo,
            "email" : email
        ]
    }
}
