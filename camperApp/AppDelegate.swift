//
//  AppDelegate.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarVC = TabBarViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: tabBarVC)
        self.window?.makeKeyAndVisible()
        setupFirebase()
        return true
    }
    
    func setupFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        //TODO: Initialise and Configure your Firebase here:A
        //let myDatabase = Database.database().reference()
    }
    
}
