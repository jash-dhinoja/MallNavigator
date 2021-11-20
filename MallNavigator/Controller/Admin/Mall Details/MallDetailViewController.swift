//
//  ProfileDetailViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 10/04/2021.
//

import UIKit
import Firebase

class MallDetailViewController: UITableViewController {

    //MARK:- Properties
    
    //TextField
    @IBOutlet weak var mallNameTextField: UITextField!
    
    //Date Picker
    @IBOutlet weak var openTimingDatePicker: UIDatePicker!
    @IBOutlet weak var closeTimingDatePicker: UIDatePicker!
    
    //Button
    @IBOutlet weak var signOutButton: UIButton!
    
    //ToDo:- edit mall detail page instead of profile
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        getMallDetail()
        configUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let mallName = mallNameTextField.text else { return }
        let openingTime = openTimingDatePicker.date
        let closingTime = closeTimingDatePicker.date
        
        let mallDetails = Mall(mallName: mallName,
                               openingFrom: openingTime,
                               openingTo: closingTime)
        guard let docID = Mall.shared?.docId else { return }
        
        Mall.shared = mallDetails
        Mall.shared?.docId = docID
        
        Firestore.firestore().collection("mallDetails").document(docID).setData(mallDetails.dictionary)
    }
    
    func configUI(){
        //TableView
        tableView.separatorStyle = .none
        
        //Text View
        if let mallDetail = Mall.shared{
            mallNameTextField.text = mallDetail.mallName
            openTimingDatePicker.date = mallDetail.openTiming
            closeTimingDatePicker.date = mallDetail.closeTiming
        }
        mallNameTextField.layer.cornerRadius = 20
        
        //Button
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.tintColor = .systemRed
    }
    
    func getMallDetail(){
        Firestore.firestore().collection("mallDetails").getDocuments { (snapshot, error) in
            if let error = error{
                self.present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
            }
            guard let snapshot = snapshot,
                  let document = snapshot.documents.first else { return }
            
            Mall.shared = Mall(dict: document.data())
            Mall.shared?.docId = document.documentID
            self.configUI()
        }
    }
    
    @IBAction func signOutButtonPressed(sender: UIButton){
        do{
            try Auth.auth().signOut()
        }catch let error as NSError{
            print("Sign Out Error:- \(error.localizedDescription)")
        }
        
        let nextVC = storyboard?.instantiateViewController(identifier: "loginVC") as! LoginViewController
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: nextVC)
    }
}
