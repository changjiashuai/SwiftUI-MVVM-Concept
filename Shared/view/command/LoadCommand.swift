//
//  LoadCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation


/// Command to load Store with params
class LoadCommand: StoreCommand{

    //set of params
    let params: [String:String]
    //Do something after loading
    private let callback: (() -> Void)
    
    /// <#Description#>
    /// - Parameters:
    ///   - params: set of params
    ///   - callback: Do something after loading
    init (params: [String:String]?, callback: (() -> Void)?){
        self.params = params ?? [:]
        self.callback = callback ?? {}
    }

    
    /// Load data
    /// - Parameter store: controlled store
    override func execute<T:Model, U: Proxy>(store : RemoteStore<T,U>){
        store.load(params: params, callback: callback)
    }
}
