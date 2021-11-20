//
//  ProductDetailViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 18/04/2021.
//

import UIKit

class ProductDetailViewController: UITableViewController {
    
    //MARK:- Properties
    
    var currentProduct: Product?
    var categoryPickerView = UIPickerView()
    
    var doneButtonCompletionHandler: ((Product) -> Void)?
    
    //ImageView
    @IBOutlet weak var mainImageView: UIImageView!
    
    //TextField
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descTextField: UITextView!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        configUI()
    }
    
    func configUI(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        //TableView
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        //ImageView
        mainImageView.image = UIImage(named: "photo2")
        mainImageView.contentMode = .scaleToFill
        
        //TextField
        nameTextField.placeholder = "Solid T-Shirts"
        priceTextField.placeholder = "30.50"
        priceTextField.keyboardType = .decimalPad
        categoryTextField.placeholder = "Men"
        categoryTextField.inputView = categoryPickerView
        
        if let currentProduct = currentProduct{
            nameTextField.text = currentProduct.name
            priceTextField.text = currentProduct.price
            categoryTextField.text = currentProduct.category
            descTextField.text = currentProduct.description
        }
        
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    
    @objc func doneButtonPressed(){
        guard let storeNo = Store.shared?.storeNo,
              let name = nameTextField.text,
              let price = priceTextField.text,
              let category = categoryTextField.text,
              let desc = descTextField.text else { return }

        var newProduct = Product(storeNo: storeNo,
                                 image: "photo2",
                                 name: name,
                                 price: price,
                                 category: category,
                                 description: desc)
        if let currentProduct = currentProduct{
            newProduct.docId = currentProduct.docId
        }
        
        if let doneHandler = doneButtonCompletionHandler{
            doneHandler(newProduct)
        }
        dismiss(animated: true)
    }
    
}

//MARK:- PickerView Delegate and Datasource Methods
extension ProductDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProductCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ProductCategory.allCases[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = ProductCategory.allCases[row].description
        view.endEditing(true)
    }
}

//MARK:- Search Controller Methods
extension ProductDetailViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        dismiss(animated: true)
    }
}

