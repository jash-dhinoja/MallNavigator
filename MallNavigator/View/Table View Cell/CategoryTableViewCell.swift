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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categroryNameLabel.font = categroryNameLabel.font.withSize(CGFloat(20))
        categroryNameLabel.textColor = Theme.colorPallete.ghostWhite.color
        numberOfShopsLabel.font = numberOfShopsLabel.font.withSize(CGFloat(40))
        numberOfShopsLabel.textColor = Theme.colorPallete.ghostWhite.color
     
        selectionStyle = .none
        
        cellHolderView.applyShadow(true)
        
        cellHolderView.backgroundColor = Theme.colorPallete.indigoDye.color
    }
    
    func configCell(category: Category){
        categroryNameLabel.text = category.name
        numberOfShopsLabel.text = String(category.numberOfShops)
    }
}
