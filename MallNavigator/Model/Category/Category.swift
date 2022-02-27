//
//  Category.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import UIKit

struct Category {
    
    var name: String
    var numberOfShops: Int
    var mainImage: String
    
    init(name: String, numberOfShops: Int, mainImage: String) {
        self.name = name
        self.numberOfShops = numberOfShops
        self.mainImage = mainImage
    }
    
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
        let numberOfShops = dict["numberOfShops"] as? Int,
        let mainImage = dict["mainImage"] as? String else { return nil}
        
        self.init(name: name,
                  numberOfShops: numberOfShops,
                  mainImage: mainImage)
        
    }
    
    var dictionary: [String: Any]{
        return[
            "name": name,
            "numberOfShops": numberOfShops,
            "mainImage": mainImage
        ]
    }
    
}

class CategoryList{
 
    static var list = [
        Category(name: "Shop", numberOfShops: 20, mainImage: "shop_banner"),
        Category(name: "Entertain", numberOfShops: 17, mainImage: "entertainment_banner"),
        Category(name: "Dine", numberOfShops: 34, mainImage: "dine_banner-1")
    ]
}
