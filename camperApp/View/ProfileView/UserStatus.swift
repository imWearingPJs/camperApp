//
//  UserStatus.swift
//  camperApp
//
//  Created by Michael Kozub on 10/18/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import Foundation

class UserStatus {
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        return defaults.bool(forKey: "isLoggedIn")
    }
}
