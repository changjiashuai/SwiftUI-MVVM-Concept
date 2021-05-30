//
//  Authentication.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation
import Data

/// `Handler` is responsible for cheking the right to execute a command acording the state of authentication
public class Authentication: ObservableObject, AuthenticationAPI {
   
    
    /// State of authentication
    @Published public private(set) var authenticated = false
    
    /// authenticated user
    private var user: AuthenticatedUser? = nil
    
    // MARK: - Life circle
    
    public init(){}
    
    // MARK: - API Methods
    
    /// Get authenticated user name
    /// - Returns: user name
    public func getAuthenticatedUserName() -> String{
        return user?.name ?? ""
    }
    
    /// Attempt to  authenticate
    public func signIn(){
        authenticated = true
        self.user = AuthenticatedUser(id: Int.random(in: 1...102), name: "User \(Int.random(in: 1...102))")
    }
    
    
    /// Leave the current app session
    public func signOut(){
        authenticated = false
        user = nil
    }
    
    ///Generate secret token to prove level of access to communicate with remote sources
    /// - Returns: Secret token
    public func getToken() -> String {
        guard authenticated else {
            return ""
        }
        /// Generate secret token
        return "\(Int.random(in: 1...1_000_000)) \(user?.name.uppercased() ?? "")"
    }
    
    /// Chek the right to execute a command
    public func handle(_ command : StoreCommand) -> HandlerError? {
        if authenticated == false{
            return .notAuthenticated
        }

        return nil
    }
}
