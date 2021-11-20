//
//  Store.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import Foundation
import FirebaseFirestore

struct Event{
    
    var docId = ""
    var name: String
    var startDate: Date
    var endDate: Date
    var description: String
    var category: Category
    var eventHolder: EventHolder
    
    
    init(eventName: String, eventStartDate: Date, eventEndDate: Date,eventCategory : Category,description: String,holder: EventHolder){
        self.name = eventName
        self.startDate = eventStartDate
        self.endDate = eventEndDate
        self.category = eventCategory
        self.description = description
        self.eventHolder = holder
    }
    
    init?(dict: [String: Any]){
        guard let name = dict["name"] as? String,
              let startDate = dict["startDate"] as? Timestamp,
              let endDate = dict["endDate"] as? Timestamp,
              let description = dict["description"] as? String,
              let category = Category(dict: dict["category"] as! [String: Any]),
              let eventHolder = EventHolder(dict: dict["eventHolder"] as! [String: Any]) else { return nil}
        
        self.init(eventName: name,
                  eventStartDate: startDate.dateValue(),
                  eventEndDate: endDate.dateValue(),
                  eventCategory: category,
                  description: description,
                  holder: eventHolder)
    }
    
    var dictionary: [String: Any]{
        return[
            "name": name,
            "startDate": startDate,
            "endDate": endDate,
            "description": description,
            "category": category.dictionary,
            "eventHolder": eventHolder.dictionary,
        ]
    }
}
