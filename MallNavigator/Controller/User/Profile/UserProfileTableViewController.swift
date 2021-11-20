//
//  UserProfileTableViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/04/2021.
//

import UIKit
import FirebaseAuth

class UserProfileTableViewController: UITableViewController {

    //MARK:- Properties
    
    //TextField
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Button
    @IBOutlet weak var signOutButton: UIButton!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI(){
        
        //TextField
        emailTextField.placeholder = "johndoe@gmail.com"
        passwordTextField.placeholder = "*****"
        passwordTextField.isSecureTextEntry = true
        
        if let currentUser = CurrentUser.shared{
            emailTextField.text = currentUser.email
            passwordTextField.text = "johndoe123"
        }
        
        //Button
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.tintColor = .red
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
