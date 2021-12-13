//
//  TextField.swift
//  MallNavigator
//
//  Created by pro on 09/12/2021.
//

import UIKit

class TextField: UITextField{
    
    //MARK: Text EdgeInset
    let padding = UIEdgeInsets(top: 0, left: Theme.textPaddingLeft, bottom: 0, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
