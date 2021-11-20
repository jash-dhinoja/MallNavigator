//
//  ShopOwnerLoginViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 17/04/2021.
//

import UIKit
import Firebase

class ShopOwnerLoginViewController: UIViewController {

    
    //MARK:- Properties
    var storeList = [Store]()
    
    //Picker View
    let storeNoPickerView = UIPickerView()
    
    //Text Field
    @IBOutlet weak var storeNoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        storeNoPickerView.delegate = self
        storeNoPickerView.dataSource = self
        
        configUI()
        fetchFirebaseData()
    }
    
    func configUI(){
        
        //Text Field
        storeNoTextField.placeholder = "Select Store"
        storeNoTextField.inputView = storeNoPickerView
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
    }
    
    func fetchFirebaseData(){
        Firestore.firestore().collection("stores").getDocuments { (snapshot, error) in
            let storeList = snapshot?.documents.map({ (document) -> Store in
                var store = Store(dictionary: document.data())
                store?.docId = document.documentID
                return store!
            })
            self.storeList = storeList ?? [Store]()
        }
    }
    
    //Button Handler
    @IBAction func loginButtonPressed(_ sender: UIButton){
        guard let pass = passwordTextField.text,
              let store = Store.shared else { return }
        
        if store.password == pass{
            let nextVC = storyboard?.instantiateViewController(identifier: "mainTabVC")
            nextVC?.modalPresentationStyle = .fullScreen
            present(nextVC!, animated: true)
        }else{
            present(UIAlertController.errorAlert(message: "Wrong Password"), animated: true)
        }
    }
}

extension ShopOwnerLoginViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storeList[row].storeNo + " - " + storeList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Store.shared = storeList[row]
        storeNoTextField.text = storeList[row].storeNo + " - " + storeList[row].name
        view.endEditing(true)
    }
}
