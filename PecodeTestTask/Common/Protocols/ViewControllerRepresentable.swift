//
//  ViewControllerRepresentable.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

protocol ViewControllerRepresentable: AnyObject {
    var view: UIView! { get }
}
