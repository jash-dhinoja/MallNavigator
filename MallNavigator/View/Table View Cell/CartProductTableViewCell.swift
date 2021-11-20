//
//  CartProductTableViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 19/04/2021.
//

import UIKit

class CartProductTableViewCell: UITableViewCell {

    //MARK:- Properties
    
    //Image
    @IBOutlet weak var productImageView: UIImageView!
    
    //Label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK:- Handlers
    func configUI(product: Product){
        //ImageView
        productImageView.image = UIImage(named: product.image)
        productImageView.contentMode = .scaleToFill
        
        //Label
        nameLabel.text = product.name
        categoryLabel.text = product.category
        priceLabel.text = product.price
    }

}
