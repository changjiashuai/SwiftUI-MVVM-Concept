//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation

/// Defines command for store from a UI control
public class StoreCommand: Command {
    
    /// Time stamp to differ repeating the same command several times in a row
    public let date: Date
    
    /// Set of params
    public let params: Params?
    
   
    /// Initializer
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    public required init (params: Params? = nil, date : Date = Date()){
        self.params = params
        self.date = date
    }
       
    // MARK: - API Methods
    
    /// Execute command method
    public func execute<T: Store>(store : T){ }

}
