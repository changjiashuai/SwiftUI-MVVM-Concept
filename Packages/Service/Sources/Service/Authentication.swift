//
//  Authentication.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


public class Authentication: ObservableObject, AuthenticationAPI {
    
    /// State of authentication
    @Published public var authenticated = false
    
    /// authenticated user
    @Published public var user: String?
    
    public init(){}
    
    /// Attempt to  authenticate
    public func signIn(){
        authenticated = true
        user = "User \(Int.random(in: 1...102))"
    }
    
    public func signOut(){
        authenticated = false
        user = nil
    }
}
