//
//  UserStoreViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit
import FirebaseFirestore

class UserStoreViewController: UIViewController {

    //MARK:- Properties
    var currentStore: Store?
    
    var productList = [Product]()
    var filterProductList = [Product]()
    
    var offerList = [Offer]()
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    //TableView
    @IBOutlet weak var productTableView: UITableView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Solid T-Shirt, ..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        configUI()
        loadProductFirebaseData()
        loadOfferFirebaseData()
    }
    
    func configUI(){
        
        title = currentStore?.name
        
        productTableView.tableFooterView = UIView()
        
    }
    
    func loadProductFirebaseData(){
        guard  let store = currentStore else { return }
        Firestore.firestore().collection("products")
            .whereField("storeNo", isEqualTo: store.storeNo)
            .getDocuments { (snapshot, error) in
                if let error = error{
                    self.present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
                }
                
                let products = snapshot?.documents.map({ (document) -> Product in
                    if var pr = Product(dict: document.data()){
                        pr.docId = document.documentID
                        return pr
                    }
                    return Product(storeNo: "1",
                                   image: "photo1",
                                   name: "Not Real",
                                   price: "10.00",
                                   category: "Men",
                                   description: "")
                })
                
                self.productList = products ?? [Product]()
                self.productTableView.reloadData()
            }
    }
    
    func loadOfferFirebaseData(){
        guard let store = currentStore else { return }
            Firestore.firestore()
                .collection("offers")
                .whereField("storeNo", isEqualTo: store.storeNo)
                .getDocuments{ (snapshot, error) in
                let offers = snapshot?.documents.map({ (document) -> Offer in
                    if var of = Offer(dict: document.data()){
                        of.docId = document.documentID
                        return of
                    }
                    return Offer(storeNo: "",
                                 title: "Not Real",
                                 productCategory: ProductCategory.Men.description,
                                 imageView: "photo1",
                                 startDate: Date(),
                                 endDate: Date())
                })
                
                self.offerList = offers ?? [Offer]()
                self.productTableView.reloadData()
            }
        
    }
    
    func filterProductSearchBar(_ searchText: String){
        filterProductList = productList.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        productTableView.reloadData()
    }
}


extension UserStoreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productList.isEmpty{
            return 1
        }
        return isSearching ? filterProductList.count : productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if productList.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell")
            return cell ?? UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductCellTableViewCell
        let product = productList[indexPath.row]
        var applicableOffers = [Offer]()
            offerList.forEach { (offer) in
            if offer.category == product.category{
                applicableOffers.append(offer)
            }
        }
        cell.configCell(product: product, hasOffer: !applicableOffers.isEmpty)
        
        var offerString = ""
        
        applicableOffers.forEach { (offer) in
            offerString += offer.title + "\n"
        }
        
        offerString += "\n * This offers will be appplied at checkout"
        
        cell.viewOfferButtonCompletion = {
            let alert = UIAlertController(title: "Offers", message: offerString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if productList.isEmpty{
            return UITableViewCell().bounds.height
        }
        return 139
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let productVC = storyboard?.instantiateViewController(identifier: "productMainVC") as! ProductMainViewController
        productVC.currentProdut = productList[indexPath.row]
        navigationController?.pushViewController(productVC, animated: true)
    }
}


//MARK:- Search Controller Methods
extension UserStoreViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterProductSearchBar(searchController.searchBar.text ?? "")
    }
}
