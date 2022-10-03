//
//  UserDetailsStore.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation
import Locksmith

class UserDetailsStore {

    // MARK: - Private properties
    private static let accessTokenKey = "auth.accessToken"
    private static let refreshTokenKey = "auth.refreshToken"

    // MARK: - Public properties
    static let clientId = ""
    static let clientSecret = ""

    static var accessToken: String? {
        get {
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: bundleId)
            return dictionary?[UserDetailsStore.accessTokenKey] as? String
        }
        set {
            storeValueInKeychain(UserDetailsStore.accessTokenKey, newValue: newValue)
        }
    }

    static var refreshToken: String? {
        get {
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: bundleId)
            return dictionary?[UserDetailsStore.refreshTokenKey] as? String
        }
        set {
            storeValueInKeychain(UserDetailsStore.refreshTokenKey, newValue: newValue)
        }
    }

    // MARK: - Methods
    public static func isUserLoggedIn() -> Bool {
        guard let accessToken = accessToken,
            let refreshToken = refreshToken else {
                return false
        }

        return !accessToken.isEmpty && !refreshToken.isEmpty
    }

    public static func setUserAuthInfo(accessToken: String?, refreshToken: String?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        UserDefaults.standard.isUserAuthDataNeeded = true
    }

    public static func clear() {
        UserDetailsStore.accessToken = nil
        UserDetailsStore.refreshToken = nil
        UserDefaults.standard.isUserAuthDataNeeded = false
    }

    // MARK: - Keychain
    private static func storeValueInKeychain(_ key: String, newValue: String?) {
        do {
            var dictionary = Locksmith.loadDataForUserAccount(userAccount: bundleId) ?? [String: Any]()
            dictionary[key] = newValue
            try Locksmith.updateData(data: dictionary, forUserAccount: bundleId)
        } catch {
            Log.error(error)
        }
    }

    private static var bundleId: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}
