//
//  EditVC.swift
//  camperApp
//
//  Created by Michael Kozub on 4/23/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage
import SVProgressHUD

protocol MapRefreshDelegate: class {
    func refreshData()
}

class EditVC: UIViewController {
    
    var camper: CamperDataModel?
    weak var delegate: MapRefreshDelegate?
    
    let nameField = UITextField()
    let idField = UITextView()
    let latField = UITextView()
    let lonField = UITextView()
    let saveBtn = UIButton()

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupKeyboard()
        addAndConfigureViews()
        super.viewDidLoad()
    }
    
    func setupKeyboard() {
        nameField.delegate = self
        self.hideKeyboardWhenTapped()
    }
    
    func addAndConfigureViews() {
        view.addSubview(nameField)
        view.addSubview(idField)
        view.addSubview(latField)
        view.addSubview(lonField)
        view.addSubview(saveBtn)
        
        nameField.text = camper?.name
        nameField.textAlignment = .center
        nameField.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        nameField.heightAnchor == 35
        nameField.centerAnchors == view.safeAreaLayoutGuide.centerAnchors
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.layer.borderWidth = 2
        
        idField.text = String(camper!.id)
        idField.isEditable = false
        idField.textAlignment = .center
        idField.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        idField.heightAnchor == 35
        idField.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        idField.topAnchor == nameField.bottomAnchor + 10
        idField.layer.borderColor = UIColor.black.cgColor
        idField.layer.borderWidth = 2
        
        latField.text = String(camper!.coordinate.latitude)
        latField.isEditable = false
        latField.textAlignment = .center
        latField.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        latField.heightAnchor == 35
        latField.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        latField.topAnchor == idField.bottomAnchor + 10
        latField.layer.borderColor = UIColor.black.cgColor
        latField.layer.borderWidth = 2

        lonField.text = String(camper!.coordinate.longitude)
        lonField.isEditable = false
        lonField.textAlignment = .center
        lonField.widthAnchor == view.safeAreaLayoutGuide.widthAnchor - 25
        lonField.heightAnchor == 35
        lonField.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        lonField.topAnchor == latField.bottomAnchor + 10
        lonField.layer.borderColor = UIColor.black.cgColor
        lonField.layer.borderWidth = 2
        
        saveBtn.layer.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3450980392, blue: 0.1607843137, alpha: 1)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        saveBtn.centerXAnchor == view.safeAreaLayoutGuide.centerXAnchor
        saveBtn.topAnchor == lonField.bottomAnchor + 15
        saveBtn.widthAnchor == view.safeAreaLayoutGuide.widthAnchor / 4
        saveBtn.heightAnchor == 35
        saveBtn.layer.cornerRadius = 7
        saveBtn.addTarget(self, action: #selector(saveButtonTapped(sender:)), for: .touchUpInside)
        
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        SVProgressHUD.show()
        APIManager().updateData(id: camper?.id, name: nameField.text) { (Bool) in
            self.dismiss(animated: true) {
                self.delegate?.refreshData()
            }
            SVProgressHUD.dismiss()
        }
    }
    
}
