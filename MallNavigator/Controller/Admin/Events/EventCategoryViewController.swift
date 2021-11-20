//
//  ShopCategoryViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 25/03/2021.
//

import UIKit

class EventCategoryViewController: UIViewController {

    //MARK:- Properties
    
    let categoryList = Category.categoryList
    
    //TableView
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Events"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        
    }
}

extension EventCategoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        
        let currentCategory = categoryList[indexPath.row]
        
        cell.configCell(category: currentCategory)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO:- Animate Cell
        
        let eventListVC = storyboard?.instantiateViewController(identifier: "eventListVc") as! EventListViewController
        eventListVC.currentCategory = categoryList[indexPath.row]
        let navController = UINavigationController(rootViewController: eventListVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
