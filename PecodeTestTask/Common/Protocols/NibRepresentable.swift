//
//  NibRepresentable.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

protocol NibRepresentable {
    static var nib: UINib { get }
    static var identifier: String { get }
}
