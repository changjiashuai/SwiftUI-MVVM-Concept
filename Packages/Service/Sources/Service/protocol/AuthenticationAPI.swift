//
//  AuthenticationAPI.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation

/// API for authenticating
public protocol AuthenticationAPI {
   
    /// Attempt to  authenticate
    func signIn()

    /// Attempt to log out from the app
    func signOut()

    ///Generate secret token to prove level of access to communicate with remote sources
    func getToken() -> String
}
