//
//  UIViewController+Extension.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
