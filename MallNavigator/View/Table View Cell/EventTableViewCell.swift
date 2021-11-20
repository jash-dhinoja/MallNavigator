//
//  StoreTableViewCell.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    //Label
    @IBOutlet weak private var eventNameLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    //View
//    @IBOutlet weak private var eventContainerView: UIView!
//    @IBOutlet weak private var iconContainerView: UIView!
    
    //Image View
//    @IBOutlet weak private var deleteIconImageView: UIImageView!
    
    //Button
    @IBOutlet weak private var iconImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Label
        eventNameLabel.font = eventNameLabel.font.withSize(22)
        dateLabel.font = dateLabel.font.withSize(12)
        dateLabel.textColor = .lightGray
    }
    
    func configUI(event: Event){
        
        eventNameLabel.text = event.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy"
        
        let startDateString = formatter.string(from: event.startDate).split(separator: "/")[0] + " " + formatter.string(from: event.startDate).split(separator: "/")[1]
        
        let endDateString = formatter.string(from: event.endDate).split(separator: "/")[0] + " " + formatter.string(from: event.endDate).split(separator: "/")[1]
        
        let dateString = startDateString + " - " + endDateString
            
        dateLabel.text = String(dateString)
        
    }
}
