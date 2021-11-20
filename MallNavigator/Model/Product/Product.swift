//
//  Product.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import Foundation

struct Product {
    
    var docId = ""
    var storeNo: String
    var image: String
    var name: String
    var price: String
    var category: String
    var description: String
    var isFav: Bool = false
    
    var dictionary: [String: Any]{
        return[
            "storeNo": storeNo,
            "image": image,
            "name": name,
            "price": price,
            "category": category,
            "description": description,
            "isFav": isFav
            
        ]
    }
    
    internal init(storeNo: String, image: String, name: String, price: String, category: String, description: String, isFav: Bool = false) {
        self.storeNo = storeNo
        self.image = image
        self.name = name
        self.price = price
        self.category = category
        self.description = description
        self.isFav = isFav
    }
    
    init?(dict: [String: Any]){
        guard let storeNo = dict["storeNo"] as? String,
              let image = dict["image"] as? String,
              let name = dict["name"] as? String,
              let price = dict["price"] as? String,
              let category = dict["category"] as? String,
              let description = dict["description"] as? String,
              let isFav = dict["isFav"] as? Bool else { return nil}
        
        self.init(storeNo: storeNo,
                  image: image,
                  name: name,
                  price: price,
                  category: category,
                  description: description,
                  isFav: isFav)
    }
    
}
