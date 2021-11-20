//
//  DashboardViewController.swift
//  MallNavigator
//
//  Created by pro on 21/03/2021.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK:- Properties
    
    let offers = [
        Offer(title: "Upto 20% off", imageView: UIImage.init(named: "photo1")!, color: .black),
        Offer(title: "20% - 40% off", imageView: UIImage.init(named: "photo2")!, color: .red),
        Offer(title: "Flat 80% off", imageView: UIImage.init(named: "photo3")!, color: .green),
        Offer(title: "Upto 20% off", imageView: UIImage.init(named: "photo4")!, color: .yellow)
    ]
    
    let cellScale = CGFloat(0.6)
    
    //Collection View
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout = offerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        
        layout.itemSize = CGSize(width: cellWidth,height: cellHeight)
        
        layout.minimumLineSpacing = 20
        
        offerCollectionView.showsHorizontalScrollIndicator = false
        offerCollectionView.collectionViewLayout = layout
        offerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offerCollectionView.dataSource = self
        
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScale)
//        let cellHeight = floor(screenSize.height * cellScale)
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        
//        offerCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        configUI()
    }
    
    func configUI(){
        //Collection View
        
        //Navigation bar
        title = "Dashboard"
//        navigationItem.leftBarButtonItem = nil
//        navigationItem.hidesBackButton = true
//        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension DashboardViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCarouselCell", for: indexPath) as! ImageCasrouselCollectionViewCell
        let currentOffer = offers[indexPath.row]
        cell.configUI(offer: currentOffer)
        return cell
    }
    
}

//extension DashboardViewController: UICollectionViewDelegate, UIScrollViewDelegate{
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = offerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//
//        let roundIndex = round(index)
//
//        offset = CGPoint(x: roundIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//    }
//
//}
