//
//  CategoryTableViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak private var categroryNameLabel: UILabel!
    @IBOutlet weak private var numberOfShopsLabel: UILabel!
    @IBOutlet weak private var cellHolderView: UIView!
    @IBOutlet weak private var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIConfiguration()
    }
    
    func UIConfiguration(){
        
        selectionStyle = .none
        
        //Label
        categroryNameLabel.font = categroryNameLabel.font.withSize(CGFloat(20))
        categroryNameLabel.textColor = Theme.colorPallete.ghostWhite.color
        categroryNameLabel.applyShadow()
        numberOfShopsLabel.font = numberOfShopsLabel.font.withSize(CGFloat(40))
        numberOfShopsLabel.textColor = Theme.colorPallete.ghostWhite.color
        
        //Cell Holder View
        cellHolderView.applyShadow(true)
        cellHolderView.backgroundColor = Theme.colorPallete.indigoDye.color
        
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.applyShadow(true)
    }
    
    func configCell(category: Category){
        categroryNameLabel.text = category.name
        numberOfShopsLabel.text = ""
//        numberOfShopsLabel.text = String(category.numberOfShops)
        cellImageView.image = UIImage(named: category.mainImage)
    }
}
