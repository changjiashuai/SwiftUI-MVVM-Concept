//
//  AuthenticationAPI.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation

/// API for authenticating
public protocol AuthenticationAPI : Handler {
   
    /// Get authenticated user name
    /// - Returns: user name
    func getAuthenticatedUserName() -> String
    
    /// Attempt to  authenticate
    func signIn()

    /// Attempt to log out from the app
    func signOut()

    ///Generate secret token to prove level of access to communicate with remote sources
    /// - Returns: Secret token
    func getToken() -> String
}
