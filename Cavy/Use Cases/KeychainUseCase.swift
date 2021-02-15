//
//  KeychainUseCase.swift
//  Cavy
//
//  Created by Avery Pierce on 2/14/21.
//

import Foundation
import Security

class KeychainUseCase {
    
    /// Stores a user's JWT token in the secure keychain, keyed by username and host
    /// - Parameters:
    ///   - jwt: JWT string returned from a successful authentication
    ///   - username: username which the JWT matches
    ///   - host: the host (domain name) of the lemmy instance you're saving for
    func storeJWT(_ jwt: String, forUser username: String, onServer host: String) {
        let jwtData = jwt.data(using: .utf8)!
        
        let keychainItemQuery = [
            kSecClass: kSecClassInternetPassword,
            kSecValueData: jwtData,
            kSecAttrAccount: username,
            kSecAttrServer: host,
            kSecAttrDescription: "Lemmy session JWT",
        ] as CFDictionary
        
        let status = SecItemAdd(keychainItemQuery, nil)
        print("Operation finished with status: \(status)")
    }
    
    
    /// Retrieve the JWT for a specific user and server
    /// - Parameters:
    ///   - username: the user's username on this Lemmy instance
    ///   - host: the host (domain name) of the Lemmy instance
    /// - Returns: The JWT for this server and username
    func findJWT(forUser username: String, onServer host: String) -> String? {
        
        // https://developer.apple.com/documentation/security/keychain_services/keychain_items/searching_for_keychain_items
        let keychainItemQuery = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: host,
            kSecAttrAccount: username,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(keychainItemQuery, &item)

        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else {
            print("Unhandled keychain error on findJWT: \(status)")
            return nil
        }
        
        guard let existingItem = item as? [CFString: Any],
              let jwtData = existingItem[kSecValueData] as? Data,
              let jwt = String(data: jwtData, encoding: String.Encoding.utf8)
        else {
            print("Unexpected password data")
            return nil
        }
        
        return jwt
    }
    
    func deleteJWT(forUser username: String, onServer host: String) {
        let keychainItemQuery = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: username,
            kSecAttrServer: host,
        ] as CFDictionary
        
        let status = SecItemDelete(keychainItemQuery)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print("Unexpected keychain error on deleteJWT: \(status)")
            return
        }
    }
    
    func deleteAllJWT(forServer host: String) {
        let keychainItemQuery = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: host,
        ] as CFDictionary
        
        let status = SecItemDelete(keychainItemQuery)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print("Unexpected keychain error on deleteJWT: \(status)")
            return
        }
    }
}
