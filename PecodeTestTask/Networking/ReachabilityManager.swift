//
//  ReachabilityManager.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation
import Alamofire

protocol ReachabilityManagerDelegate: AnyObject {
    func statusChanged(isReachable: Bool)
}

final class ReachabilityManager {
    
    // MARK: - Private properties
    private let reachabilityManager = NetworkReachabilityManager.default
    
    // MARK: - Public properties
    weak var delegate: ReachabilityManagerDelegate?
    
    // MARK: - Lifecycle
    init() {
        self.setupManager()
    }
    
    // MARK: - Private methods
    private func setupManager() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            self.delegate?.statusChanged(isReachable: status != .notReachable)
        })
    }
}
