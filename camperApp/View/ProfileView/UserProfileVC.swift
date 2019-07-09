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
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        addAndConfigureViews()
    }
    
    func addAndConfigureViews() {
        view.addSubview(testLabel)
        
        testLabel.text = "Successfully logged in!!"
        testLabel.textAlignment = .center
        testLabel.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        testLabel.heightAnchor == 35
        testLabel.centerAnchors == view.safeAreaLayoutGuide.centerAnchors
        
    }
    
}
