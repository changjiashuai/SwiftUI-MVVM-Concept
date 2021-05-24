//
//  Proxy.swift
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation


/// Defines a communication layer with a remote source of data
public protocol Proxy {
    
    /// Defines an element of Store
    associatedtype Item    
    /// Processes data fetched from a remote source
    associatedtype AbstractReader: Reader
    /// Defines specs for a request
    associatedtype AbstractRequest: Request
    /// Contains result of retrieved data
    associatedtype AbstractResponse: Response
    
    ///Dic for a request params
    typealias Params = [String: String]
    
    /// Parses data loaded from remote source
    var reader: AbstractReader { get }
    
    /// Create request
    /// - Parameter params: set of params to control what data to get from a remote source Range, Filter etc
    /// - Returns: specs of request
    func createRequest(params: Params?) -> AbstractRequest
    
    /// Create response
    /// - Parameters:
    ///   - request: Initial request
    ///   - error: Errors desc for View
    ///   - items: Store items
    func createResponse(_ request: AbstractRequest,_ error: DataError?,_ items: [Item]) -> AbstractResponse
    
    /// Fetch data from a remote source
    /// - Parameter request: Defines specs of request
    func run(_ request: AbstractRequest) -> AbstractResponse
}
