//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation
import Data

/// Defines command for store from a UI control
public class StoreCommand: Equatable {
    
    /// Time stamp to differ repeating the same command several times in a row
    let date = Date()
       
    // MARK: - API Methods
    
    /// Execute command method
    public func execute<V:Model, U: Proxy>(store : RemoteStore<V,U>){ }
    
    /// Compare values for equality or inequality
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: Returns a Boolean value indicating whether two values are equal
    public static func == (lhs: StoreCommand, rhs: StoreCommand) -> Bool {
        lhs.date == rhs.date
    }
}
