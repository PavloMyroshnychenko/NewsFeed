//
//  MainNavigationController.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

final class MainNavigationController: UINavigationController {

    // MARK: - Private properties
    private var viewController: UIViewController {
        let viewController = NewsFeedViewController.instantiateFromStoryboard()
        let presenter = NewsFeedPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRootViewController()
    }
    
    // MARK: - Private methods
    private func setRootViewController() {
        self.viewControllers = [viewController]
    }
}
