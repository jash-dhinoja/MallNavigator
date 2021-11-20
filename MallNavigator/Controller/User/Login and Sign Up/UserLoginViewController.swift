//
//  UserLoginViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/04/2021.
//

import UIKit
import GoogleSignIn

class UserLoginViewController: UIViewController {

    //MARK:- Properties
    
    //TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Button
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    
    func configUI(){
        //TextFields
        emailTextField.placeholder = "John Doe"
        passwordTextField.placeholder = "JohnDoe@123"
        passwordTextField.isSecureTextEntry = true
        LoginButton.setTitle("Login", for: .normal)
        SignInButton.setTitle("Sign In", for: .normal)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        guard let mainTabVC = storyboard?.instantiateViewController(identifier: "mainTabVC") else { return }
        mainTabVC.modalPresentationStyle = .fullScreen
        present(mainTabVC, animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton){
        guard let signInVC = storyboard?.instantiateViewController(identifier: "signInVC") else { return }
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
    }
}
