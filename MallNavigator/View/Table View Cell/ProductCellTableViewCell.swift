//
//  ProductCellTableViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit

class ProductCellTableViewCell: UITableViewCell {

    //MARK:- Properties
    var favButtonPressed: (() -> Void)?
    var viewOfferButtonCompletion: (() -> Void)?
    
    //Label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //Image View
    @IBOutlet weak var productImage: UIImageView!
    
    //Button
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var offerButton: UIButton!

    //MARK:- Handlers
    func configCell(product: Product, hasOffer: Bool){
        //Label
        nameLabel.text = product.name
        categoryLabel.text = product.category
        priceLabel.text = "$" + product.price
        
        //Image View
        productImage.image = UIImage(named: product.image)
        productImage.contentMode = .scaleToFill
        
        //Button
        favoriteButton.addTarget(self, action: #selector(favButtonPressed(isFav:)), for: .touchUpInside)
        favButtonPressed(isFav: product.isFav)
        offerButton.isHidden = !hasOffer
        offerButton.setTitle("View Offer", for: .normal)
        offerButton.addTarget(self, action: #selector(offerButtonPressed), for: .touchUpInside)
    }
    
    @objc func favButtonPressed(isFav: Bool){
        favoriteButton.imageView?.image = isFav ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        favoriteButton.imageView?.tintColor = isFav ? .systemRed : .systemGray2
        if let favHandler = favButtonPressed{
            favHandler()
        }
    }
    
    @objc func offerButtonPressed(){
        if let completionHandler = viewOfferButtonCompletion{
            completionHandler()
        }
    }
    
}
