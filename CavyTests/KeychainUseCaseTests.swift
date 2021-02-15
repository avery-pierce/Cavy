//
//  KeychainUseCaseTests.swift
//  CavyTests
//
//  Created by Avery Pierce on 2/14/21.
//

import XCTest
@testable import Cavy

class KeychainUseCaseTests: XCTestCase {
    
    override func tearDown() {
        KeychainUseCase().deleteAllJWT(forServer: "example.com")
    }

    func testStoreJWT() throws {
        let bogusJWT = "Som bogus JWT string. Doesn't matter."
        let user = "john_appleseed"
        let server = "example.com"
        KeychainUseCase().storeJWT(bogusJWT, forUser: user, onServer: server)
        
        let output = KeychainUseCase().findJWT(forUser: user, onServer: server)
        XCTAssertEqual(output, bogusJWT)
    }
    
    func testEmptyJWT() throws {
        let output = KeychainUseCase().findJWT(forUser: "jane_appleseed", onServer: "example.com")
        XCTAssertNil(output)
    }
    
    func testDeleteJWT() throws {
        let bogusJWT = "pika pika, pikachu!"
        let user = "pikachu"
        let server = "example.com"
        KeychainUseCase().storeJWT(bogusJWT, forUser: user, onServer: server)
        
        // Soundness testing – make sure the token was actually stored.
        let check = KeychainUseCase().findJWT(forUser: user, onServer: server)
        XCTAssertEqual(check, bogusJWT)
        
        KeychainUseCase().deleteJWT(forUser: user, onServer: server)
        
        // If the key was deleted, this should nil
        let output = KeychainUseCase().findJWT(forUser: user, onServer: server)
        XCTAssertNil(output)
    }
    
    func testDeleteAllJWTForServer() throws {
        let bogusJWT = "pika pika, pikachu!"
        let user = "pikachu"
        let server = "example.com"
        KeychainUseCase().storeJWT(bogusJWT, forUser: user, onServer: server)
        
        KeychainUseCase().deleteAllJWT(forServer: server)
        
        // If the key was deleted, this should nil
        let output = KeychainUseCase().findJWT(forUser: user, onServer: server)
        XCTAssertNil(output)
    }
}
