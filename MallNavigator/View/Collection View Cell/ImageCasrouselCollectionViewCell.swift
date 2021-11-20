//
//  ImageCasrouselCollectionViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 21/03/2021.
//

import UIKit

class ImageCasrouselCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerLabel: UILabel!
    
    func configUI(offer: Offer){
        
        offerImageView.contentMode = .scaleAspectFill
        offerImageView.clipsToBounds = true
        offerLabel.text = offer.title
        
        offerImageView.layer.cornerRadius = 10
        offerImageView.layer.masksToBounds = true
    }
    
}
