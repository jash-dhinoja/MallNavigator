//
//  ViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/03/2021.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController {

    //MARK:- Properties
    //TextField
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Button
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        guard let email = usernameTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
                let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: UIButton){
        
                guard let email = usernameTextField.text,
                      let password = passwordTextField.text else { return }
            
                FirebaseAuthManager().createUser(email: email, password: password) {[weak self] (success) in
                    guard let `self` = self else { return }
                    var message: String = ""
                    if (success) {
                        message = "User was sucessfully created."
                    } else {
                        if let username = self.usernameTextField.text, let password = self.usernameTextField.text{
                            if username.isEmpty || password.isEmpty{
                                message = "Please fill up the username/password textfields"
                            }else{
                                message = "There was an error."
                            }
                        }
                    }

                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true)
                }
    }
}
