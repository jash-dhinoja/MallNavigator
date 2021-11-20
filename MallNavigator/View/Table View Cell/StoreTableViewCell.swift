//
//  ShopTableViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 03/04/2021.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    //MARK:- Properties
    
    //Label
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var shopOwnerLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    //Image View
    @IBOutlet weak var shopImageView: UIImageView!
    
    //MARK:- Handlers
    override func awakeFromNib() {
        super.awakeFromNib()
        shopNameLabel.font = UIFont.boldSystemFont(ofSize: shopNameLabel.font.pointSize)
        floorLabel.font = UIFont.boldSystemFont(ofSize: floorLabel.font.pointSize)
    }
    
    func configUI(store: Store){

        shopImageView.contentMode = .scaleAspectFill
        
        shopNameLabel.text = store.name
        shopOwnerLabel.text = store.owner
        floorLabel.text = store.floor.description
        shopImageView.image = UIImage(named: store.mainImage)
    }
}
