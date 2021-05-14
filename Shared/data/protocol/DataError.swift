//
//  DataError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import Foundation


/// Data error
protocol DataError: Error {
    
    /// Get error description
    func getDescription() -> String
}
