//
//  DashboardViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 16/04/2021.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK:- Properties
    var eventList = [
        TestEvent(name: "Art Exibition", image: "shop_banner", duratoin: "21 May to 23rd May"),
        TestEvent(name: "Dine and test", image: "dine_banner-1", duratoin: "21 May to 23rd May"),
        TestEvent(name: "Movie Night", image: "entertainment_banner", duratoin: "21 May to 23rd May")
    ]
    
    //Collection View
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    let cellScale = 0.7
    var cellSize = CGSize.zero
    var cellInset = UIEdgeInsets()
    
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()

//        let screenSize = UIScreen.main.bounds.size
//
//        let cellWidth = floor(screenSize.width * cellScale)
//        let cellHeight = floor(eventCollectionView.bounds.height * cellScale)
//
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//
//        cellSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        title = "Trending Offer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
    }
    
    func snapToCenter() {
        let centerPoint = CGPoint(x: eventCollectionView.bounds.midX,
                                  y: eventCollectionView.bounds.midY)
        guard let centerIndexPath = eventCollectionView.indexPathForItem(at: centerPoint) else { return }
        eventCollectionView.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
      }
}

//MARK: Collection View Delegate
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToCenter()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            snapToCenter()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) ->
//
//        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//    }
}

//MARK: Collection View Datasource
extension DashboardViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.max
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardEventCell", for: indexPath) as!
        DashboardEventCollectionViewCell
        cell.configCell(event: eventList[indexPath.item % eventList.count])
        return cell
    }
}

struct TestEvent{
    
    var name: String
    var image: String
    var duratoin: String
    
    internal init(name: String, image: String, duratoin: String) {
        self.name = name
        self.image = image
        self.duratoin = duratoin
    }
    
}
