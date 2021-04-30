//
//  AbstractStore.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation


/// Defines repository with data
protocol Store {
    associatedtype Item: Model
    associatedtype AbstractProxy: Proxy

    /// Defines communication layer with remote source of data
    var proxy: AbstractProxy { get set }
       
    /// Load data from a remote source
    /// - Parameters:
    ///   - params: Defines specs for requested data
    ///   - callback: Do something after data is loaded
    func load(params:[String:String]? ,callback: @escaping () -> Void)
    
    
    /// Append an element
    /// - Parameter item: an element of store
    func append(_ item: Item)
    
    
    /// Append set of elements
    /// - Parameter items: elements of store
    func appendAll(_ items: [Item])
    
    
    /// Remove all elements
    func removeAll()
}

