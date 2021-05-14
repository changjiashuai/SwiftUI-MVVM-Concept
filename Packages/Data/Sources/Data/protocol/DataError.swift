//
//  DataError.swift
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import Foundation


/// Data error
public protocol DataError: Error {
    
    /// Get error description
    func getDescription() -> String
}
