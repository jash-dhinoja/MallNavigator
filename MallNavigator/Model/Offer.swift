//
//  Offer.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 21/03/2021.
//

import UIKit
import FirebaseFirestore

struct Offer{
    
    var docId = ""
    var storeNo: String
    var title: String
    var category: String
    var image: String
    var startDate: Date
    var endDate: Date
    
    var dictionary: [String: Any]{
        return[
            "storeNo": storeNo,
            "title": title,
            "category": category,
            "image": image,
            "startDate": startDate,
            "endDate": endDate
        ]
    }
    
    init(storeNo: String,title: String,productCategory: String, imageView: String,startDate: Date, endDate: Date ) {
        self.title = title
        self.category = productCategory
        self.image = imageView
        self.storeNo = storeNo
        self.startDate = startDate
        self.endDate = endDate
    }
    
    init?(dict: [String: Any]){
        guard let storeNo = dict["storeNo"] as? String,
              let title = dict["title"] as? String,
              let productCategory = dict["category"] as? String,
              let image = dict["image"] as? String,
              let startDate = dict["startDate"] as? Timestamp,
              let endDate = dict["endDate"] as? Timestamp else { return nil}
        
        self.init(storeNo: storeNo,
                  title: title,
                  productCategory: productCategory,
                  imageView: image,
                  startDate: startDate.dateValue(),
                  endDate: endDate.dateValue())
        
    }
    
}
