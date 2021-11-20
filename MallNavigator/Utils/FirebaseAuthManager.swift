//
//  FirebaseAuthManager.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 21/03/2021.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager{
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ sucess: Bool) -> Void ){
        
        Auth.auth().createUser(withEmail: email,
                               password: password) { authResult, error in
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{
                completionBlock(false)
            }
        }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                print(error.localizedDescription)
                completionBlock(false)
            } else {
                dump(result?.user)
                completionBlock(true)
            }
        }
    }
}
