//
//  ShopListTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 03/04/2021.
//

import UIKit
import FirebaseFirestore

class ShopListViewController: UIViewController {

    //MARK:- Properties
    var currentCategory: Category?
    
    var shopList = [Store]()
    var filteredStore = [Store]()
    var storeNoTaken = [String]()
    
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
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Nike, Adidas,..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        storeListTableView.delegate = self
        storeListTableView.dataSource = self
        
        configUI()
        loadDataFirebase()
    }
    
    func configUI(){
        //Navigation Bar
        title = currentCategory?.name
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        storeListTableView.rowHeight = 139
        storeListTableView.separatorStyle = .singleLine
        storeListTableView.tableFooterView = UIView()
    }
    
    func filterShopsSearchBar(_ searchText: String){
        filteredStore = shopList.filter({ (store) -> Bool in
            return store.name.lowercased().contains(searchText.lowercased())
        })
        storeListTableView.reloadData()
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    
    @objc func addButtonPressed(){
        let nextVC = storyboard?.instantiateViewController(identifier: "shopDetailVC") as! ShopDetailViewController
        
        nextVC.doneButtonCompletionHandler = { store in
            let collection = Firestore.firestore().collection("stores")
            var store = store
            store.categoryName = self.currentCategory?.name ?? ""
            collection.addDocument(data: store.dictonary)
            self.loadDataFirebase()
        }
        
        nextVC.storeNoTaken = storeNoTaken
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }
    
    func loadDataFirebase(){
        
        storeNoTaken = []
        
        Firestore.firestore().collection("stores").getDocuments{ (snapshot, error) in
            let stores = snapshot?.documents.map({ (document) -> Store in
                if var st = Store(dictionary: document.data()){
                    st.docId = document.documentID
                    self.storeNoTaken.append(st.storeNo)
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
            
            self.shopList = stores ?? [Store]()
            self.storeListTableView.reloadData()
        }
    }
}

//MARK:- TableView Delegate and DataSource
extension ShopListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredStore.count : shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell") as! StoreTableViewCell
        
        let currentStore = isSearching ? filteredStore[indexPath.row] : shopList[indexPath.row]
        
        cell.configUI(store: currentStore)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let shopVC = storyboard?.instantiateViewController(identifier: "shopDetailVC") as! ShopDetailViewController
        
        let currentStore = isSearching ? filteredStore[indexPath.row] : shopList[indexPath.row]
        shopVC.currentStore = currentStore
        
        var takenStores = storeNoTaken
        
        takenStores.removeAll { (storeNo) -> Bool in
            return storeNo == currentStore.storeNo
        }
        
        shopVC.storeNoTaken = takenStores
        
        shopVC.doneButtonCompletionHandler = { store in
            let document = Firestore.firestore().collection("stores").document(store.docId)
            document.setData(store.dictonary,merge: true)
            self.loadDataFirebase()
        }
        
        let navController = UINavigationController(rootViewController: shopVC)
        navController.presentationController?.delegate = shopVC
        present(navController,animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(shopList[indexPath.row].name)", message: "Are you sure you want delete \" \(shopList[indexPath.row].name)\" ?", preferredStyle: .actionSheet)
            
            let deleteStore = isSearching ? filteredStore[indexPath.row] : shopList[indexPath.row]
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                Firestore.firestore()
                    .collection("stores")
                    .document(deleteStore.docId)
                    .delete { (error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                        self.shopList.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
}

//MARK:- Search Controller Methods
extension ShopListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterShopsSearchBar(searchController.searchBar.text ?? "")
    }
}
