//
//  Label.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/03/2021.
//

import UIKit

class Label: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    required init(){
        
        super.init(frame: CGRect.zero)
        frame = CGRect(x: 0, y: 0, width: frame.width + Theme.textPaddingLeft, height: frame.height)
        insets = UIEdgeInsets(top: 0, left: Theme.textPaddingLeft, bottom: 0, right: 0)
        
        textColor = UIColor.lightText
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
    
}
