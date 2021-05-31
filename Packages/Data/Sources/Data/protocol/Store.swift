//
//  AbstractStore.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation


/// Defines repository with data
public protocol Store {
    
    ///Dic for a request params
    typealias Params = [String: String]
    
    /// Defines an element of Store
    associatedtype Item: Model
    /// Defines a communication layer with a remote source of data
    associatedtype AbstractProxy: Proxy
    
    /// Contains error string if loading ends up with errors
    var error: String? { get set }
    
    /// Indicates state of loading
    var loading: Bool { get set }
    
    /// Defines communication layer with remote source of data
    var proxy: AbstractProxy { get set }
       
    /// Load data from a remote source
    /// - Parameters:
    ///   - params: Defines specs for requested data
    ///   - callback: Do something after data is loaded
    func load(params:Params?)
    
    /// Amount of items in Store
    func count() -> Int
    
    /// Append an element
    /// - Parameter item: an element of store
    func append(_ item: Item)
    
    /// Append set of elements
    /// - Parameter items: elements of store
    func appendAll(_ items: [Item])
    
    /// Get if Store is empty
    /// - Returns: true if empty
    func isEmpty() -> Bool
    
    /// Remove all elements
    func removeAll()

}

