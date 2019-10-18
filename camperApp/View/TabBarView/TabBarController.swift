//
//  TabBarController.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let isLoggedIn = UserStatus().isLoggedIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTabs()
    }
    
    public func updateTabs() {
        // Create Tab one
        let mapTab = MapViewController()
        mapTab.title = "Let's find a Camper"
        let mapTabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map-24.png"), selectedImage: UIImage(named: "map-24.png"))
        
        mapTab.tabBarItem = mapTabBarItem
        
        // Create Tab two
        var profileTab: UINavigationController!
        if isLoggedIn == false {
            profileTab = UINavigationController(rootViewController: LoginViewController())
        } else {
            profileTab = UINavigationController(rootViewController: UserProfileVC())
            LoginViewController().setLoggedInStatus()
        }
        profileTab.title = "Login"
        profileTab.navigationBar.isHidden = true
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user-24.png"), selectedImage: UIImage(named: "user-24.png"))
        profileTab.tabBarItem = profileTabBarItem
        
        self.viewControllers = [mapTab, profileTab]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
