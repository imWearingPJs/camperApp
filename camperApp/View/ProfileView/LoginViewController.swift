//
//  LoginViewController.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
    
    let userName = UITextField()
    let password = UITextField()
    let loginButton = UIButton()
    let newActButton = UIButton()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()

        setupKeyboard()
        addAndConfigureViews()
    }
    
    func setupKeyboard() {
        userName.delegate = self
        password.delegate = self
        self.hideKeyboardWhenTapped()
    }
    
    func addAndConfigureViews() {
        view.addSubview(userName)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(newActButton)
        
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
        
        loginButton.layer.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3450980392, blue: 0.1607843137, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        loginButton.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        loginButton.topAnchor == password.bottomAnchor + 15
        loginButton.widthAnchor == view.safeAreaLayoutGuide.widthAnchor / 4
        loginButton.heightAnchor == 35
        loginButton.layer.cornerRadius = 7
        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        
        newActButton.setTitle("Need an Account?", for: .normal)
        newActButton.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        newActButton.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        newActButton.topAnchor <= loginButton.bottomAnchor + 15
        newActButton.heightAnchor == 35
        newActButton.addTarget(self, action: #selector(newActTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped(sender: UIButton) {
        self.setLoggedInStatus()
        self.navigationController?.pushViewController(UserProfileVC(), animated: true)
        TabBarViewController().updateTabs()
    }
    
    func setFailedStatus() {
        self.defaults.set(false, forKey: "isLoggedIn")
        self.defaults.set(nil, forKey: "idToken")
    }
    
    func setLoggedInStatus() {
        self.defaults.set(true, forKey: "isLoggedIn")
    }
    
    @objc func newActTapped(sender: UIButton) {
        let registrationVC = RegistrationViewController()
        self.navigationController?.pushViewController(registrationVC, animated: false)
    }
    
    func addFailureAlert(){
        let title = "Bummer!"
        let message = "Looks like something went wrong! Not sure exactly what though since we're still developing this app."
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
