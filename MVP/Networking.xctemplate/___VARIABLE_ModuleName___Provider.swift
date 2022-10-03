//  ___FILEHEADER___

import Moya

enum ___VARIABLE_ModuleName___Provider { }

// MARK: - TargetType
extension ___VARIABLE_ModuleName___Provider: TargetType {

    var baseURL: URL {
        URL(string: Environment.configuration(.serverUrl))!
    }

    var path: String {
        ""
    }

    var method: Moya.Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        nil
    }

    var validationType: ValidationType {
        .successCodes
    }
}
