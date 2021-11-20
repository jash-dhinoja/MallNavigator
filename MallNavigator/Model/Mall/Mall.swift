//
//  File.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 10/04/2021.
//

import Foundation
import FirebaseFirestore

struct Mall{
    
    static var shared: Mall?
    
    var docId = ""
    var mallName = ""
    var openTiming = Date()
    var closeTiming = Date()
    
    init(mallName: String, openingFrom: Date, openingTo: Date) {
        self.mallName = mallName
        self.openTiming = openingFrom
        self.closeTiming = openingTo
    }
    
    init?(dict: [String: Any]){
        guard let mallName = dict["mallName"] as? String,
              let openTiming = dict["openTiming"] as? Timestamp,
              let closeTiming = dict["closeTiming"] as? Timestamp else { return nil}
        
        self.init(mallName: mallName,
                  openingFrom: openTiming.dateValue(),
                  openingTo: closeTiming.dateValue())
    }
    
    var dictionary: [String: Any]{
        return [
            "mallName": mallName,
            "openTiming": openTiming,
            "closeTiming": closeTiming
        ]
    }
}
