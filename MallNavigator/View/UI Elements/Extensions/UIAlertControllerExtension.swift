//
//  UIAlertControllerExtension.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 15/04/2021.
//

import UIKit

extension UIAlertController{
    
    static func errorAlert(message: String) -> UIAlertController{
        let alert = self.init(title: "Error Occured!",
                  message: message,
                  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        return alert
    }
    
}
