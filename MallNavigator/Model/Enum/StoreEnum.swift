//
//  StoreEnum.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 11/04/2021.
//

import Foundation

enum StoreEnum: CustomStringConvertible {
    case shop
    case dine
    case entertain
    
    var description: String{
        switch self{
        case .shop: return "Shop"
        case .dine: return "Dine"
        case .entertain: return "Entertain"
        }
    }
}
