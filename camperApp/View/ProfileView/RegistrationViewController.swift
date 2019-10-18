//
//  RegistrationViewController.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage
import FirebaseAuth
import SVProgressHUD

class RegistrationViewController: UIViewController {
    
    let userName = UITextField()
    let password = UITextField()
    let password2 = UITextField()
    let createButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        setupKeyboard()
        addAndConfigureViews()
    }
    
    func setupKeyboard() {
        userName.delegate = self
        password.delegate = self
        password2.delegate = self
        self.hideKeyboardWhenTapped()
    }
    
    func addAndConfigureViews() {
        view.addSubview(userName)
        view.addSubview(password)
        view.addSubview(password2)
        view.addSubview(createButton)
        
        userName.placeholder = "Email"
        userName.textAlignment = .center
        userName.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        userName.heightAnchor == 35
        userName.centerAnchors == view.safeAreaLayoutGuide.centerAnchors
        userName.layer.borderColor = UIColor.black.cgColor
        userName.layer.borderWidth = 2
        userName.autocapitalizationType = .none
        
        password.placeholder = "Password"
        password.textAlignment = .center
        password.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        password.heightAnchor == 35
        password.centerXAnchor == userName.centerXAnchor
        password.topAnchor == userName.bottomAnchor + 15
        password.layer.borderColor = UIColor.black.cgColor
        password.layer.borderWidth = 2
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        
        password2.placeholder = "Password Again"
        password2.textAlignment = .center
        password2.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        password2.heightAnchor == 35
        password2.centerXAnchor == userName.centerXAnchor
        password2.topAnchor == password.bottomAnchor + 15
        password2.layer.borderColor = UIColor.black.cgColor
        password2.layer.borderWidth = 2
        password2.autocapitalizationType = .none
        password2.isSecureTextEntry = true
        
        createButton.layer.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3450980392, blue: 0.1607843137, alpha: 1)
        createButton.setTitle("Login", for: .normal)
        createButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        createButton.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        createButton.topAnchor == password2.bottomAnchor + 15
        createButton.widthAnchor == view.safeAreaLayoutGuide.widthAnchor / 4
        createButton.heightAnchor == 35
        createButton.layer.cornerRadius = 7
        createButton.addTarget(self, action: #selector(createButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func createButtonTapped(sender: UIButton) {
        SVProgressHUD.show()
        self.navigationController?.pushViewController(UserProfileVC(), animated: true)
    }
    
    func addFailureAlert(){
        let title = "Bummer!"
        let message = "Looks like something went wrong! Not sure exactly what though since we're still developing this app."
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
