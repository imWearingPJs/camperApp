//
//  UserProfileVC.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import Foundation
import Anchorage

class UserProfileVC: UIViewController {
    
    let testLabel = UILabel()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        addAndConfigureViews()
    }
    
    func addAndConfigureViews() {
        view.addSubview(testLabel)
        view.addSubview(dismissButton)
        
        testLabel.text = "Welcome to your account!!"
        testLabel.textAlignment = .center
        testLabel.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        testLabel.heightAnchor == 35
        testLabel.centerAnchors == view.safeAreaLayoutGuide.centerAnchors
        
        dismissButton.layer.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3450980392, blue: 0.1607843137, alpha: 1)
        dismissButton.setTitle("Logout", for: .normal)
        dismissButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        dismissButton.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        dismissButton.topAnchor == testLabel.bottomAnchor + 15
        dismissButton.widthAnchor == view.safeAreaLayoutGuide.widthAnchor / 4
        dismissButton.heightAnchor == 35
        dismissButton.layer.cornerRadius = 7
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func dismissButtonTapped(sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLoggedIn")
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        TabBarViewController().updateTabs()
    }
    
}
