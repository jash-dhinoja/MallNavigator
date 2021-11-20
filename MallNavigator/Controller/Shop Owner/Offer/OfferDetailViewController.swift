//
//  OfferDetailViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 17/04/2021.
//

import UIKit

class OfferDetailViewController: UITableViewController {

    //MARK:- Properties
    
    var currentOffer: Offer?
    
    var doneButtonCompletionHandler: ((Offer) -> Void)?
    
    var categoryPickerView = UIPickerView()
    
    //TextField
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    //ImageView
    @IBOutlet weak var mainImageView: UIImageView!
    
    //DatePicker
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
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
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        //TextField
        titleTextField.placeholder = "Winter Clearance - 50 % OFF"
        categoryTextField.placeholder = "Men"
        categoryTextField.inputView = categoryPickerView
        
        //ImageView
        mainImageView.image = UIImage(named: "photo4")
        mainImageView.contentMode = .scaleToFill
        
        //DatePicker
        startDatePicker.minimumDate = Date()
        endDatePicker.minimumDate = startDatePicker.date
        
        if let currentOffer = currentOffer{
            titleTextField.text = currentOffer.title
            categoryTextField.text = currentOffer.category
            mainImageView.image = UIImage(named: currentOffer.image)
            startDatePicker.setDate(currentOffer.startDate, animated: true)
            endDatePicker.setDate(currentOffer.endDate, animated: true)
            startDateChanged(startDatePicker)
        }
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    
    @objc func doneButtonPressed(){
        guard let title = titleTextField.text,
              let category = categoryTextField.text,
              let storeNo = Store.shared?.storeNo else { return }
        var newOffer = Offer(storeNo: storeNo,
                             title: title,
                             productCategory: category,
                             imageView: "photo3",
                             startDate: startDatePicker.date,
                             endDate: endDatePicker.date)
        
        if let currentOffer = currentOffer{
            newOffer.docId = currentOffer.docId
        }
        
        if let doneHandler = doneButtonCompletionHandler{
            doneHandler(newOffer)
        }
        dismiss(animated: true)
    }
    
    @IBAction func startDateChanged(_ sender: UIDatePicker){
        if endDatePicker.date < startDatePicker.date{
            endDatePicker.setDate(startDatePicker.date, animated: true)
        }
        endDatePicker.minimumDate = startDatePicker.date
    }
}

//MARK:- PickerView Delegate and Datasource Methods
extension OfferDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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

//MARK:- Adaptive Presentation Delegate
extension OfferDetailViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        backButtonPressed()
    }
}
