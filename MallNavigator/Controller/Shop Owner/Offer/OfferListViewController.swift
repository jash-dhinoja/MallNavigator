//
//  OfferViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 17/04/2021.
//

import UIKit
import FirebaseFirestore

class OfferListViewController: UIViewController {

    //MARK:- Properties
    
    var offerList = [Offer]()
    var filterOfferList = [Offer]()
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //Table View
    @IBOutlet weak var offerListTableView: UITableView!
    
    //MARK:- Handler
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Winter Clearane"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        offerListTableView.delegate = self
        offerListTableView.dataSource = self
        offerListTableView.tableFooterView = UIView()
        
        configUI()
        loadDataFirebase()
    }
    
    func configUI(){
        title = "Offers"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    func filterShopsSearchBar(_ searchText: String){
        filterOfferList = offerList.filter({ (offer) -> Bool in
            return offer.title.lowercased().contains(searchText.lowercased())
        })
        offerListTableView.reloadData()
    }
    
    @objc func addButtonPressed(){
        let nextVC = storyboard?.instantiateViewController(identifier: "offerDetailVC") as! OfferDetailViewController
        
        nextVC.doneButtonCompletionHandler = { offer in
            let collection = Firestore.firestore().collection("offers")
            
            collection.addDocument(data: offer.dictionary)
            self.loadDataFirebase()
        }
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }

    func loadDataFirebase(){
        Firestore.firestore()
            .collection("offers")
            .whereField("storeNo", isEqualTo: Store.shared?.storeNo ?? "")
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
            self.offerListTableView.reloadData()
        }
    }
}

extension OfferListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filterOfferList.count : offerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle,reuseIdentifier: nil)
        let currentOffer = isSearching ? filterOfferList[indexPath.row] : offerList[indexPath.row]
        cell.textLabel?.text = currentOffer.title
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let dateRangeString = formatter.string(from: currentOffer.startDate) + " to " + formatter.string(from: currentOffer.endDate)
        
        cell.detailTextLabel?.text = dateRangeString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = storyboard?.instantiateViewController(identifier: "offerDetailVC") as! OfferDetailViewController
        nextVC.modalPresentationStyle = .fullScreen
        
        let selectedOffer =  isSearching ? filterOfferList[indexPath.row] : offerList[indexPath.row]
        nextVC.currentOffer = selectedOffer
        
        nextVC.doneButtonCompletionHandler = { offer in
            let document = Firestore.firestore().collection("offers").document(offer.docId)
            document.setData(offer.dictionary)
            self.loadDataFirebase()
        }
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(offerList[indexPath.row].title)", message: "Are you sure you want delete \" \(offerList[indexPath.row].title)\" ?", preferredStyle: .actionSheet)
            
            let deleteOffer = isSearching ? filterOfferList[indexPath.row] : offerList[indexPath.row]
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                Firestore.firestore()
                    .collection("offers")
                    .document(deleteOffer.docId)
                    .delete { (error) in
                        if let error = error{
                            self.present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
                            return
                        }
                        self.offerList.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
}

extension OfferListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterShopsSearchBar(searchController.searchBar.text ?? "")
    }
}
