//
//  ShopTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 06/04/2021.
//

import UIKit

class ShopCategoryTableViewController: UIViewController {
    
    //MARK:- Properties
    let categoryList = Category.categoryList
    
    //Table View
    @IBOutlet weak var shopCategoryTable: UITableView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopCategoryTable.delegate = self
        shopCategoryTable.dataSource = self
        
        configUI()
    }
    
    func configUI(){
        title = "Stores"
        
        shopCategoryTable.rowHeight = 200
        shopCategoryTable.separatorStyle = .none
        
    }
}

extension ShopCategoryTableViewController: UITableViewDelegate,UITableViewDataSource{
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
        
        //TODO:- Animate cell code
        let shopVC = storyboard?.instantiateViewController(identifier: "shopList") as! ShopListViewController
        shopVC.currentCategory = categoryList[indexPath.row]
        let navController = UINavigationController(rootViewController: shopVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
