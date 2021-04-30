//
//  User.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation


/// Model defining User
struct User: Model {
    
    let id: Int    
    
    /// user's name
    let name: String
    
    /// user's age
    let age: Int
}
