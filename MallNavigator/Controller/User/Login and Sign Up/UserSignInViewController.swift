//
//  UserSignInViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/04/2021.
//

import UIKit

class UserSignInViewController: UIViewController {
    //MARK:- Properties
    
    //TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    //Button
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    
    func configUI(){
        //TextFields
        emailTextField.placeholder = "John Doe"
        passwordTextField.placeholder = "JohnDoe@123"
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.placeholder = "JohnDoe@123"
        confirmPasswordTextField.isSecureTextEntry = true
        LoginButton.setTitle("Login", for: .normal)
        SignInButton.setTitle("Sign In", for: .normal)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton){
        guard let mainTabVC = storyboard?.instantiateViewController(identifier: "mainTabVC") else { return }
        mainTabVC.modalPresentationStyle = .fullScreen
        present(mainTabVC, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        dismiss(animated: true)
    }

}
