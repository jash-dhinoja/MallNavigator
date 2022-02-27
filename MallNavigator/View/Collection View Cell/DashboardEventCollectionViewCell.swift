//
//  DashboardEventCollectionViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 22/01/2022.
//

import UIKit

class DashboardEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var eventImageView: UIImageView!
    @IBOutlet private var eventNameLabel: UILabel!
    @IBOutlet private var eventDurationLabel: UILabel!
    
    func configCell(event: TestEvent){
        
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.applyShadow(true)
        
        eventImageView.image = UIImage(named: event.image)
        
        eventNameLabel.text = event.name
        eventDurationLabel.text = event.duratoin
        
    }
    
}
