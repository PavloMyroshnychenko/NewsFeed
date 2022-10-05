//
//  EnvironmentInterceptor.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Alamofire

struct EnvironmentInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        Log.info("🚀 Running request: \(urlRequest.httpMethod ?? "") - \(urlRequest.url?.absoluteString ?? "")")
        
        let authKey = "Authorization"
        let userAgentKey = "User-Agent"
        
        var urlRequest = urlRequest
        
        if urlRequest.allHTTPHeaderFields?[authKey] != nil,
           let currentUserAuth = UserDetailsStore.accessToken {
            urlRequest.setValue("Bearer " + currentUserAuth, forHTTPHeaderField: authKey)
        }
        let userAgent = UAString()
        urlRequest.setValue(userAgent, forHTTPHeaderField: userAgentKey)
        return completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }

        guard let refreshToken = UserDetailsStore.refreshToken else {
            completion(.doNotRetryWithError(error))
            return
        }
    }
}
