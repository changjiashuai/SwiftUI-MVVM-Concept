//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation


/// Defines command for store from a UI control
public struct StoreCommand: Command {
    
    /// Time stamp to differ repeating the same command several times in a row
    public let date: Date
    
    /// Set of params
    public let params: Params?
    
    /// type of the command
    public let type: CommandType
    
    
    /// Initializer
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    public init (_ type: CommandType, params: Params? = nil, date: Date = Date()) {
        self.params = params
        self.type = type
        self.date = date
    }
    
    // MARK: - API Methods
    
    /// Execute command method
    public func execute<T: Store>(store: T) {
        switch type {
        case .read:
            store.load(params: params)
        case .delete:
            store.removeAll()
        case .create:
            idle()
        case .update:
            idle()
        case .idle:
            idle()
        }
    }
    
    private func idle() { }
    
}
