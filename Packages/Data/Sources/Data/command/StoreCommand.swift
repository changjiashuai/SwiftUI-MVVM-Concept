//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation

/// Defines command for store from a UI control
public class StoreCommand: Command {
    
    /// Optinal closure type for a collback
    public typealias CallbackClosure = () -> Void
    
    /// Time stamp to differ repeating the same command several times in a row
    let date = Date()
    
    /// Set of params
    public let params: Params?
    
    /// Do something after loading
    public let callback: CallbackClosure?
    
    /// Initializer
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    public init (params: Params? = nil, callback: CallbackClosure? = nil){
        self.params = params
        self.callback = callback
    }
       
    // MARK: - API Methods
    
    /// Execute command method
    public func execute<T: Store>(store : T){ }
    
    /// Compare values for equality or inequality
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: Returns a Boolean value indicating whether two values are equal
    public static func == (lhs: StoreCommand, rhs: StoreCommand) -> Bool {
        lhs.date == rhs.date
    }
}
