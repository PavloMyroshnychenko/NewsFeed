//
//  UIStoryboard+Identifier.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

extension UIStoryboard {
    var identifier: String {
        return String(describing: self)
    }
}
