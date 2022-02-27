//
//  SearchCategoryViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit

class SearchCategoryViewController: UIViewController {

    //MARK:- Properties
    
    let categoryList = CategoryList.list
    
    //Table View
    @IBOutlet weak var categoryTableView: UITableView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource  = self
        
        categoryTableView.register(UINib(nibName: "CategoryCellView", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
        configUI()
    }
    
    func configUI(){
        title = "Stores"
        
        categoryTableView.rowHeight = 196
        categoryTableView.separatorStyle = .none
    }
}

extension SearchCategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        cell.configCell(category: categoryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO:- Animate cell code
        let shopVC = storyboard?.instantiateViewController(identifier: "shopList") as! UserStoreListViewController
        shopVC.currentCategory = categoryList[indexPath.row]
        let navController = UINavigationController(rootViewController: shopVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
}
