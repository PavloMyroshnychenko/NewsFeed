//
//  Environment.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation

struct Environment {

    // MARK: - PlistKey
    enum PlistKey: String {
        case serverUrl = "server_url"
    }

    // MARK: - Private Methods
    private static var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }

    // MARK: - Static Methods
    static func configuration(_ key: PlistKey) -> String {
        (infoDict["App configuration"] as! [String: Any])[key.rawValue] as! String
    }
    
    static func appName() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
}
