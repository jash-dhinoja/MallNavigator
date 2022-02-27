//
//  EventListViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 26/03/2021.
//

import UIKit
import FirebaseFirestore

class EventListViewController: UIViewController {
    
    //MARK:- Properties
    
    var currentCategory : Category?
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    var eventList = [Event]()
    var filteredEvents = [Event]()
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //Table View
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let category = currentCategory else { return }
        
        
        
        title = "\(category.name)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        configUI()
        fetchFirebaseData()
    }
    
    func configUI(){
        //Navigation Bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        //Table View
        tableView.rowHeight = 95
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: tableView.separatorInset.top,
                                                left: tableView.separatorInset.left,
                                                bottom: tableView.separatorInset.bottom,
                                                right: tableView.separatorInset.left)
    }
    
    func fetchFirebaseData(){
        Firestore.firestore().collection("events").getDocuments{ (snapshot, error) in
            let events = snapshot?.documents.map({ (document) -> Event in
                
                if var et = Event(dict: document.data()){
                    et.docId = document.documentID
                    return et
                }
                
                return Event(eventName: "NotReal",
                             eventStartDate: Date(),
                             eventEndDate: Date(),
                             eventCategory: CategoryList.list.first!,
                             description: "",
                             holder: EventHolder(name: "NotOwner",
                                                 contactNo: "1234567890",
                                                 email: "email"))
            })
            
            self.eventList = events ?? [Event]()
            self.tableView.reloadData()
        }
    }
    
    func filterEventsSearchBar(_ searchText: String){
        filteredEvents = eventList.filter({ (event) -> Bool in
            return event.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    
    @objc func addButtonPressed(){
        let nextVC = storyboard?.instantiateViewController(identifier: "eventDetailVC") as! EventDetailTableViewController
        
        nextVC.doneButtonCompletionHandler = { event in
            let collection = Firestore.firestore().collection("events")
            collection.addDocument(data: event.dictionary)
            self.fetchFirebaseData()
        }
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }
}

//MARK:- TableView Delegate and Datasource Methods
extension EventListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredEvents.count
          }
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
        
        let currentEvent = isSearching ? filteredEvents[indexPath.row] : eventList[indexPath.row]
        
        cell.configUI(event: currentEvent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = storyboard?.instantiateViewController(identifier: "eventDetailVC") as! EventDetailTableViewController
        nextVC.modalPresentationStyle = .fullScreen
        
        nextVC.currentEvent = isSearching ? filteredEvents[indexPath.row] : eventList[indexPath.row]
        
        nextVC.doneButtonCompletionHandler = { event in
            let document = Firestore.firestore().collection("events").document(event.docId)
            document.setData(event.dictionary)
            self.fetchFirebaseData()
        }
        
        let navController = UINavigationController(rootViewController: nextVC)
        
        navController.presentationController?.delegate = nextVC
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(eventList[indexPath.row].name)", message: "Are you sure you want delete \" \(eventList[indexPath.row].name)\" ?", preferredStyle: .actionSheet)
            
            let deleteEvent = isSearching ? filteredEvents[indexPath.row] : eventList[indexPath.row]
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                Firestore.firestore()
                    .collection("events")
                    .document(deleteEvent.docId)
                    .delete { (error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                        self.eventList.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
}

//MARK:- SearchView Controller Methods
extension EventListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterEventsSearchBar(searchController.searchBar.text ?? "")
    }
}
