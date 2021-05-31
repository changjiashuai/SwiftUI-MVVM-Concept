//
//  LoadCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation

/// Command to load Store with params
public class LoadCommand: StoreCommand{
    
    // MARK: - Methods
    /// Load data
    /// - Parameter store: controlled store
    override public func execute<T: Store>(store : T){
        store.load(params: params)
    }
}
