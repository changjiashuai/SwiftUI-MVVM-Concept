//
//  Proxy.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation


/// Defines a communication layer with a remote source of data
protocol Proxy {
    associatedtype Item: Model
    associatedtype AbstractReader: Reader
    associatedtype AbstractRequest: Request
    associatedtype AbstractResponse: Response
    
    
    /// Parses data loaded from remote source
    var reader: AbstractReader { get set }    
    
    /// Fetch data from a remote source
    /// - Parameter request: Defines specs of request
    func run(_ request: AbstractRequest) -> AbstractResponse
    
    
    /// Create request
    /// - Parameter params: set of params to control what data to get from a remote source Range, Filter etc
    func createRequest(params: [String : String]?) -> AbstractRequest
}
