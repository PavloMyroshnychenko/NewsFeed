//
//  StoryboardInstantiatable.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

protocol StoryboardInstantiatable {}

extension StoryboardInstantiatable where Self: NibRepresentable {
    static func instantiateFromStoryboard(name: String = Self.identifier) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier)
        return viewController as! Self
    }
    
    static func instantiateLaunchScreen() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier)
        return viewController as! Self 
    }
}
