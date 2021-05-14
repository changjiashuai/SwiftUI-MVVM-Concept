//
//  Response.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Contains result of retrieved data
public protocol Response {
    
    /// Defines an element of Store
    associatedtype Item : Model
    
    /// Defines specs of request
    var request : Request { get }
    
    
    /// Parsed fetched data
    var items: [Item] { get }
    
    /// Error while parsing or fetching
    var error : DataError? { get }
}
