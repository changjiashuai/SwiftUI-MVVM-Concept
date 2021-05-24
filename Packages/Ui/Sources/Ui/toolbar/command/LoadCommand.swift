//
//  LoadCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation
import Data

/// Command to load Store with params
class LoadCommand: StoreCommand{

    /// Optinal closure type for a collback
    typealias callbackClosure = ( () -> Void )?
    
    /// Set of params
    let params: [String:String]?
    /// Do something after loading
    private let callback: callbackClosure

    // MARK: - Life circle
    
    /// Initializer
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    init (params: [String:String]? = nil, callback: callbackClosure = nil){
        self.params = params
        self.callback = callback
    }
    
    // MARK: - Methods
    /// Load data
    /// - Parameter store: controlled store
    override func execute<T:Model, U: Proxy>(store : RemoteStore<T,U>){
        store.load(params: params, callback: callback)
    }
}
