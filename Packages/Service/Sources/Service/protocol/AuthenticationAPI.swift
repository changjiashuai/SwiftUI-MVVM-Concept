//
//  AuthenticationAPI.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation

/// API for authenticating
protocol AuthenticationAPI {
    
  /// Attempt to  authenticate
  func signIn()
    
  /// Attempt to log out from the app
  func signOut()
}
