//
//  UserDefaults.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation

extension UserDefaults {
    var isUserAuthDataNeeded: Bool {
        get {
            return self.bool(forKey: Constants.UserDefaults.isUserAuthDataNeeded)
        }
        set {
            self.set(newValue, forKey: Constants.UserDefaults.isUserAuthDataNeeded)
        }
    }
}
