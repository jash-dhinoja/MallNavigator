//
//  File.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 03/04/2021.
//

import UIKit

struct Store{
    
    static var shared: Store?
    
    var docId = ""
    var storeNo: String
    var name: String
    var owner: String
    var phoneNo: String
    var email: String
    var password: String
    var floor: FloorEnum
    var mainImage: String
    var categoryName: String
    
    internal init(storeNo: String, name: String, owner: String, phoneNo: String, email: String,password: String, floor: FloorEnum, mainImage: String, categoryName: String) {
        self.storeNo = storeNo
        self.name = name
        self.owner = owner
        self.phoneNo = phoneNo
        self.email = email
        self.floor = floor
        self.mainImage = mainImage
        self.categoryName = categoryName
        self.password = password
    }
    
    init?(dictionary: [String: Any]) {
        guard let storeNo = dictionary["storeNo"] as? String,
              let name = dictionary["name"] as? String,
              let owner = dictionary["owner"] as? String,
              let phoneNo = dictionary["phoneNo"] as? String,
              let email = dictionary["email"] as? String,
              let pass = dictionary["password"] as? String,
              let floor = dictionary["floor"] as? String,
              let mainImage = dictionary["mainImage"] as? String,
              let category = dictionary["category"] as? String
        else { return nil }
        
        var a = FloorEnum.basement
        FloorEnum.allCases.forEach { (floorEnum) in
            if floorEnum.description == floor{
                a = floorEnum
            }
        }
        
        self.init(storeNo: storeNo,
                  name: name,
                  owner: owner,
                  phoneNo: phoneNo,
                  email: email,
                  password: pass,
                  floor: a,
                  mainImage: mainImage,
                  categoryName: category)
        
    }
    
    var dictonary: [String: Any]{
       return[
        "storeNo": storeNo,
        "name": name,
        "owner": owner,
        "phoneNo": phoneNo,
        "email" : email,
        "password": password,
        "floor": floor.description,
        "mainImage": mainImage,
        "category": categoryName
       ]
    }
}
