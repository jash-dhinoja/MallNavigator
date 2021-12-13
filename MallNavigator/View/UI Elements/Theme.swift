//
//  Theme.swift
//  MallNavigator
//
//  Created by pro on 09/12/2021.
//

import Foundation
import UIKit

class Theme{
//    {
//        "Indigo Dye":"033f63",
//        "Beau Blue":"bdd5ea",
//        "Ghost White":"f7f7ff",
//        "Orange Red Crayola":"fe5f55",
//        "Middle Green":"558564"
//    }
    
    static let textPaddingLeft: CGFloat = 12
    
    enum colorPallete{
        case indigoDye
        case beauBlue
        case ghostWhite
        case orangeRedCrayola
        case middleGreen
        
         var color: UIColor{
            switch self {
            case .indigoDye:
                return UIColor(rgb: 0x033f63)
            case .beauBlue:
                return UIColor(rgb: 0xbdd5ea)
            case .ghostWhite:
                return UIColor(rgb: 0xf7f7ff)
            case .orangeRedCrayola:
                return UIColor(rgb: 0xfe5f55)
            case .middleGreen:
                return UIColor(rgb: 0x55856)
            }
        }
    }
    
}
