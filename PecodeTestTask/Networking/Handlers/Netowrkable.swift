//
//  Netowrkable.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Moya
import PromiseKit

typealias PecodeTestTaskPromise<T> = Promise<T>

protocol Networkable {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
    var dataConverter: JSONDataConverterService { get }
}

extension Networkable {
    func execute(request: T) -> Promise<Data> {
        let promise = PecodeTestTaskPromise<Data>.pending()

        self.provider.request(request) { result in
            switch result {
            case .success(let moyaResponse):
                promise.resolver.fulfill(moyaResponse.data)
            case .failure(let error):
                promise.resolver.reject(error)
            }
        }
        return promise.promise
    }

    func executeAndMap<U: Decodable>(request: T) -> Promise<U> {
        return execute(request: request).compactMap(dataConverter.getParser())
    }
}
