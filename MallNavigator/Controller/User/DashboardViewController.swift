//
//  DashboardViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 16/04/2021.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK:- Properties
    var offerList = [Offer]()
    
    //Collection View
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
