//
//  UIViewExtension.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import UIKit

extension UIView{
    
    func applyShadow(_ hasCornerRadius: Bool = false){
        
        //Corner Radius
        self.layer.cornerRadius = hasCornerRadius ? 20 : 0
        
        //Shadow
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
    }
    
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                       }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                           }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
                       }
    }
}

