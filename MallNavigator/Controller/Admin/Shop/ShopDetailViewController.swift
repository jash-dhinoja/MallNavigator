//
//  ShopDetailTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 08/04/2021.
//

import UIKit
import Firebase

class ShopDetailViewController: UITableViewController {

    //MARK:- Properties
    var currentStore: Store?
    let floorPickerView = UIPickerView()
    let storePickerView = UIPickerView()
    
    var storeNoTaken = [String]()
    
    let floorData = FloorEnum.allCases
    var storeData = Array(1...100).map{ (num) -> String in
        return num.description
    }
    
    var doneButtonCompletionHandler: ((Store) -> Void)?
    
    //Text Field
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var storeNoTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerContactTextField: UITextField!
    @IBOutlet weak var ownerEmailTextField: UITextField!
    @IBOutlet weak var ownerPasswordTextField: UITextField!
    
    //Text View
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        floorPickerView.delegate = self
        floorPickerView.dataSource = self
        
        storePickerView.delegate = self
        storePickerView.dataSource = self
        
        storeData.removeAll { (storeNo) -> Bool in
            return storeNoTaken.contains(storeNo)
        }
        
        configUI()
    }
    
    func configUI(){
        
        //Navigation Bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        tableView.allowsSelection = false
        
        if let store = currentStore{
            shopNameTextField.text = store.name
            floorTextField.text = store.floor.description
            storeNoTextField.text = store.storeNo
            ownerNameTextField.text = store.owner
            ownerContactTextField.text = store.phoneNo
            ownerEmailTextField.text = store.email
            ownerPasswordTextField.text = store.password
        }
        
        //TextField
        shopNameTextField.placeholder = "Nike"
        floorTextField.placeholder = FloorEnum.firstFloor.description
        storeNoTextField.placeholder = "312"
        ownerNameTextField.placeholder = "John Doe"
        ownerContactTextField.placeholder = "(123) 456 7890"
        ownerEmailTextField.placeholder = "johnDoe@gmail.com"
        ownerPasswordTextField.text = "*******"
        floorTextField.inputView = floorPickerView
        storeNoTextField.inputView = storePickerView
    }
    
    // Navigation Button Handlers
    //Back Button Handler
    @objc func backButtonPressed(){
        print("Back Button Pressed")
        dismiss(animated: true)
    }
    //Done Button Handler
    @objc func doneButtonPressed(){
        print("Done Button Pressed")
        
        guard let name = shopNameTextField.text,
              let owner = ownerNameTextField.text,
              let phoneNo = ownerContactTextField.text,
              let email = ownerEmailTextField.text,
              let pass = ownerPasswordTextField.text,
              let storeNo = storeNoTextField.text
        else { return }
        
        let floor = floorData[floorPickerView.selectedRow(inComponent: 0)]
        
        var store = Store(storeNo: storeNo,
                          name: name,
                          owner: owner,
                          phoneNo: phoneNo,
                          email: email,
                          password: pass,
                          floor: floor,
                          mainImage: "photo1",
                          categoryName: "")
        if let currentStore = currentStore{
            store.docId = currentStore.docId
            store.categoryName = currentStore.categoryName
        }
        if let doneButtonHandler = doneButtonCompletionHandler{
            doneButtonHandler(store)
        }
        
        dismiss(animated: true)
    }
}

//MARK:- UIPickerView Delegate and Datasource methods
extension ShopDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == floorPickerView ? floorData.count : storeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == floorPickerView ? floorData[row].description : storeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == floorPickerView{
            floorTextField.text = floorData[row].description
            return
        }
        storeNoTextField.text = storeData[row]
    }
}

//MARK:- Adaptive Presentation Delegate
extension ShopDetailViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        backButtonPressed()
    }
}
