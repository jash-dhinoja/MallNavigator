//
//  SceneDelegate.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 20/03/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func changeRootViewController(vc: UIViewController){
        guard let window = window  else { return }
        
        window.rootViewController = vc
        
        UIView.transition(with: window,
                          duration: 1.0,
                          options: [.curveEaseInOut],
                          animations: nil,
                          completion: nil)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        do{
            try Auth.auth().signOut()
        }catch let error as NSError{
            print("Sign Out Error:- \(error.localizedDescription)")
        }
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                CurrentUser.shared = CurrentUser(user: user)
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                
                #if ADMIN
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                #elseif SHOPOWNER
                let storyboard = UIStoryboard(name: "ShopOwner", bundle: nil)
                #else
                let storyboard = UIStoryboard(name: "User", bundle: nil)
                #endif
                
                let tabController = storyboard.instantiateViewController(identifier: "mainTabVC") as! UITabBarController
                sceneDelegate?.changeRootViewController(vc: tabController)
                
                let tabBar = tabController.tabBar
                
                tabBar.layer.masksToBounds = true
//                tabBar.isTranslucent = true
                tabBar.barStyle = .default
                tabBar.layer.cornerRadius = 20
                tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                tabBar.backgroundColor = Theme.colorPallete.ghostWhite.color
                tabBar.tintColor = Theme.colorPallete.indigoDye.color
            }
        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

