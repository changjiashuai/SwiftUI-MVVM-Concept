//
//  Authentication.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


class Authentication: ObservableObject, AuthenticationAPI {
    
    /// State of authentication
    @Published var authenticated = false
    
    /// authenticated user
    @Published var user: String?    
    
    /// Attempt to  authenticate
    func signIn(){
        authenticated = true
        user = "User \(Int.random(in: 1...102))"
    }
}
