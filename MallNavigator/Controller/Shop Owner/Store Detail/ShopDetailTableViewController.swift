//
//  ShopDetailTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 17/04/2021.
//

import UIKit
import FirebaseFirestore

class ShopDetailTableViewController: UITableViewController {

    //MARK:- Properties
    var currentStore: Store?
    
    //Text Field
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var shopOwnerNameTextField: UITextField!
    @IBOutlet weak var shopOwnerEmailTextField: UITextField!
    @IBOutlet weak var shopOwnerContactNoTextField: UITextField!
    
    //Button
    @IBOutlet weak var signOutButton: UIButton!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentStore = Store.shared
        configUI()
    }
    
    func configUI(){
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        //Text Field
        passwordTextField.isSecureTextEntry = true
        
        if let store = currentStore{
            //Text Field
            shopNameTextField.text = store.name
            passwordTextField.text = store.password
            shopOwnerNameTextField.text = store.owner
            shopOwnerEmailTextField.text = store.email
            shopOwnerContactNoTextField.text = store.phoneNo
        }
        
        //Button
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.tintColor = .systemRed
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let name = shopNameTextField.text,
              let password = passwordTextField.text,
              let ownerName = shopOwnerNameTextField.text,
              let ownerEmail = shopOwnerEmailTextField.text,
              let ownerContact = shopOwnerContactNoTextField.text,
              var store = currentStore else { return }
        
        store.name = name
        store.password = password
        store.owner = ownerName
        store.email = ownerEmail
        store.phoneNo = ownerContact
        
        Store.shared = store
        
        Firestore.firestore().collection("stores").document(store.docId).setData(store.dictonary)
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton){
        dismiss(animated: true)
    }
}
