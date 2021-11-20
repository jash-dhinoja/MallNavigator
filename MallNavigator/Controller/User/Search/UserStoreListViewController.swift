//
//  UserSearchListViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit
import FirebaseFirestore

class UserStoreListViewController: UIViewController {

    //MARK:- Properties
    
    var currentCategory: Category?
    
    var storeList = [Store]()
    var filterStoreList = [Store]()
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //TableView
    @IBOutlet weak var storeListTableView: UITableView!
    
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeListTableView.delegate = self
        storeListTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Nike, Adidas,..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        configUI()
        loadDataFirebase()
    }
    
    func configUI(){
        title = currentCategory?.name
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonPressed))
        
        storeListTableView.rowHeight = 139
        storeListTableView.separatorStyle = .singleLine
        storeListTableView.tableFooterView = UIView()
    }
    
    func filterStoreSearchBar(_ searchText: String){
        filterStoreList = storeList.filter({ (store) -> Bool in
            return store.name.lowercased().contains(searchText.lowercased())
        })
        storeListTableView.reloadData()
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    
    func loadDataFirebase(){
        Firestore.firestore().collection("stores").whereField("category", isEqualTo: currentCategory?.name ?? "").getDocuments{ (snapshot, error) in
            let stores = snapshot?.documents.map({ (document) -> Store in
                if var st = Store(dictionary: document.data()){
                    st.docId = document.documentID
                    return st
                }
                return Store(storeNo: "312",
                             name: "Not Real",
                             owner: "John Doe",
                             phoneNo: "1234567890",
                             email: "email@gmail.com",
                             password: "pass",
                             floor: .basement,
                             mainImage: "photo1",
                             categoryName: self.currentCategory!.name)
            })
            
            self.storeList = stores ?? [Store]()
            self.storeListTableView.reloadData()
        }
    }
}

extension UserStoreListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filterStoreList.count : storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell") as! StoreTableViewCell
        
        let store = isSearching ? filterStoreList[indexPath.row] : storeList[indexPath.row]
        
        cell.configUI(store: store)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storeVC = storyboard?.instantiateViewController(identifier: "storeMainVC") as! UserStoreViewController
        storeVC.currentStore = storeList[indexPath.row]
        navigationController?.pushViewController(storeVC, animated: true)
        
    }
}

//MARK:- Search Controller Methods
extension UserStoreListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterStoreSearchBar(searchController.searchBar.text ?? "")
    }
}
