//
//  LoadCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation
import Data

/// Command to load Store with params
public class LoadCommand: StoreCommand{

    /// Optinal closure type for a collback
    public typealias CallbackClosure = () -> Void
    ///Dic for a request params
    public typealias Params = [String: String]
    
    /// Set of params
    let params: Params?
    /// Do something after loading
    private let callback: CallbackClosure?

    // MARK: - Life circle
    
    /// Initializer
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    public init (params: Params? = nil, callback: CallbackClosure? = nil){
        self.params = params
        self.callback = callback
    }
    
    // MARK: - Methods
    /// Load data
    /// - Parameter store: controlled store
    override public func execute<T: Store>(store : T){
        store.load(params: params, callback: callback)
    }
}
