//
//  PecodeTestTask.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Moya

struct PecodeTestTask {

    static let shared = PecodeTestTask()

    let network: PecodeNetwork

    private init() {

        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let loggerPlugin = NetworkLoggerPlugin(configuration: config)

        let converter = JSONDataConverterService()

        network = PecodeNetwork(
            converter: converter,
            plugins: [loggerPlugin])
    }
}
