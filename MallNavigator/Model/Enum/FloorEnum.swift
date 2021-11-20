//
//  FloorEnum.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 03/04/2021.
//

import Foundation

enum FloorEnum: CustomStringConvertible,CaseIterable {
    
    case groundFloor
    case firstFloor
    case secondFloor
    case basement
    
    
    var description: String {
        switch self{
        case .groundFloor: return "Ground Floor"
        case .firstFloor: return "First Floor"
        case .secondFloor: return "Second Floor"
        case .basement: return "Third Floor"
        }
    }
}
