//
//  PecodeProvider.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Moya

enum PecodeProvider {
    
    case topHeadlines(page: Int, searchText: String, category: String)
}

extension PecodeProvider: TargetType {
    var baseURL: URL {
        return URL(string: Environment.configuration(.serverUrl))!
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .topHeadlines(let page, let searchText, let category):
            let parameters: [String: Any] = ["country": "ua",
                                             "page": page,
                                             "q": searchText,
                                             "category": category]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        var parameters: [String: String] = [
            "Accept": "*/*"
        ]
        parameters["Authorization"] = "Bearer " + "8ff1e4430360487b8e386b32e9709188"
        return parameters
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
