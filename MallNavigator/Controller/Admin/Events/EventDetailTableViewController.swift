//
//  EventDetailTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 29/03/2021.
//

import UIKit

class EventDetailTableViewController: UITableViewController {

    //MARK:- Properties
    var currentEvent: Event?
    
    var doneButtonCompletionHandler: ((Event) -> Void)?
    
    //Text Field
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventHolderNameTextField: UITextField!
    @IBOutlet weak var eventHolderContactTextField: UITextField!
    @IBOutlet weak var eventHolderEmailTextField: UITextField!
    
    //Text View
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    
    //Date Picker
    @IBOutlet weak var eventFromDatePicker: UIDatePicker!
    @IBOutlet weak var eventToDatePicker: UIDatePicker!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI(){
        
        //Navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        tableView.allowsSelection = false
        
        //Text Field
        eventNameTextField.layer.cornerRadius = 20
        eventHolderNameTextField.layer.cornerRadius = 20
        eventHolderContactTextField.layer.cornerRadius = 20
        eventHolderEmailTextField.layer.cornerRadius = 20
        
        eventNameTextField.placeholder = "Live Music"
        eventHolderNameTextField.placeholder = "John Doe"
        eventHolderContactTextField.placeholder = "(000)000-0000"
        eventHolderEmailTextField.placeholder = "johndoe@gmail.com"
        
        //Date Picker
        eventFromDatePicker.minimumDate = Date()
        eventToDatePicker.isEnabled = false
        
        if let event = currentEvent {
            eventNameTextField.text = event.name
            eventFromDatePicker.setDate(event.startDate, animated: true)
            fromDateSet(eventFromDatePicker)
            eventToDatePicker.setDate(event.endDate, animated: true)
            eventHolderNameTextField.text = event.eventHolder.name
            eventHolderContactTextField.text = event.eventHolder.contactNo
            eventHolderEmailTextField.text = event.eventHolder.email
        }
        
        //Text View
        eventDescriptionTextField.layer.cornerRadius = 20
        
    }
    
    // Navigation Button Handlers
    //Back Button Handler
    @objc func backButtonPressed(){
        dismiss(animated: true)
    }
    //Done Button Handler
    @objc func doneButtonPressed(){
        
        guard let name = eventNameTextField.text,
              let desc = eventDescriptionTextField.text,
              let holderName = eventHolderNameTextField.text,
              let holderEmail = eventHolderEmailTextField.text,
              let holderContactNo = eventHolderContactTextField.text else { return }
        
        
        
        if let doneButtonHandler = doneButtonCompletionHandler{
            var event = Event(eventName: name,
                              eventStartDate: eventFromDatePicker.date,
                              eventEndDate: eventToDatePicker.date,
                              eventCategory: CategoryList.list.first!,
                              description: desc,
                              holder: EventHolder(name: holderName,
                                                  contactNo: holderContactNo,
                                                  email: holderEmail))
            if let currentEvent = currentEvent{
                event.docId = currentEvent.docId
            }
            doneButtonHandler(event)
        }
        dismiss(animated: true)
    }
    
    //Date Picker Handlers
    @IBAction func fromDateSet(_ sender: UIDatePicker){
        eventToDatePicker.isEnabled = true
        if eventToDatePicker.date < eventFromDatePicker.date{
            eventToDatePicker.setDate(eventFromDatePicker.date, animated: true)
        }
        eventToDatePicker.minimumDate = eventToDatePicker.date
    }
}

//MARK:- Adaptive Presentation Delegate
extension EventDetailTableViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        backButtonPressed()
    }
}
