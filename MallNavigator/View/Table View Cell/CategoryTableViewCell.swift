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
        numberOfShopsLabel.font = numberOfShopsLabel.font.withSize(CGFloat(40))
     
        selectionStyle = .none
        
        cellHolderView.applyShadow(true)
    }
    
    func configCell(category: Category){
        categroryNameLabel.text = category.name
        numberOfShopsLabel.text = String(category.numberOfShops)
    }
}
