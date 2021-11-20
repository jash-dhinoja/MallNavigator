//
//  ProductListViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit
import FirebaseFirestore

class ProductListViewController: UIViewController {

    //MARK:- Properties
    var productList = [Product]()
    var filterProductList = [Product]()
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //Table View
    @IBOutlet weak var productTableView: UITableView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        configUI()
        loadDataFirebase()
    }
    
    func configUI(){
        title = "Products"
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        productTableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    @objc func addButtonPressed(){
        let productDetailVC = storyboard?.instantiateViewController(identifier: "productDetailVC") as! ProductDetailViewController
        
        productDetailVC.doneButtonCompletionHandler = { product in
            let collection = Firestore.firestore().collection("products")
            collection.addDocument(data: product.dictionary)
            self.loadDataFirebase()
        }
        
        let navController = UINavigationController(rootViewController: productDetailVC)
        navController.presentationController?.delegate = productDetailVC
        present(navController, animated: true)
    }
    
    func filterProductsSearchBar(_ searchText: String){
        filterProductList = productList.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        productTableView.reloadData()
    }

    func loadDataFirebase(){
        Firestore.firestore()
            .collection("products")
            .whereField("storeNo", isEqualTo: Store.shared?.storeNo ?? "")
            .getDocuments{ (snapshot, error) in
            let products = snapshot?.documents.map({ (document) -> Product in
                if var pr = Product(dict: document.data()){
                    pr.docId = document.documentID
                    return pr
                }
                return Product(storeNo: "",
                               image: "photo4",
                               name: "Not Real",
                               price: "10.11",
                               category: "Men",
                               description: "Desc")
            })
            
            self.productList = products ?? [Product]()
            self.productTableView.reloadData()
        }
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filterProductList.count : productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let product = isSearching ? filterProductList[indexPath.row] : productList[indexPath.row]
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "$ " + product.price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let nextVC = storyboard?.instantiateViewController(identifier: "productDetailVC") as! ProductDetailViewController
        nextVC.modalPresentationStyle = .fullScreen
        
        nextVC.currentProduct = isSearching ? filterProductList[indexPath.row] : productList[indexPath.row]
        
        nextVC.doneButtonCompletionHandler = { product in
            let document = Firestore.firestore().collection("products").document(product.docId)
            document.setData(product.dictionary)
            self.loadDataFirebase()
        }
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(productList[indexPath.row].name)", message: "Are you sure you want delete \" \(productList[indexPath.row].name)\" ?", preferredStyle: .actionSheet)
            
            let deleteProduct = isSearching ? filterProductList[indexPath.row] : productList[indexPath.row]
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                Firestore.firestore()
                    .collection("products")
                    .document(deleteProduct.docId)
                    .delete { (error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                        self.productList.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    
}
    
}

extension ProductListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterProductsSearchBar(searchController.searchBar.text ?? "")
    }
}
