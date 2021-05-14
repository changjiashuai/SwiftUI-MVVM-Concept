//
//  User.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation
import Data

/// Model defining User
struct User: Model {    
    
    /// User ID
    let id: Int    
    
    /// User name
    let name: String
    
    /// User age
    let age: Int
}
