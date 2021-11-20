//
//  ProductCategory.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import Foundation

enum ProductCategory: CustomStringConvertible, CaseIterable{
    
    case Men
    case Women
    case Kids
    case Shoes
    case Electronics
    case Accessories
    
    var description: String{
        switch self{
        case .Men: return "Men"
        case .Women: return "Women"
        case .Kids: return "Kids"
        case .Shoes: return "Shoes"
        case .Electronics: return "Electronics"
        case .Accessories: return "Accessories"
        }
    }
    
}
    
