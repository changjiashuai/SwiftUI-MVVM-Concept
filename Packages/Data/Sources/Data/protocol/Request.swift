//
//  Request.swift
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Defines specs for a request
public protocol Request {
    
    ///Dic for a request params
    typealias Params = [String: String]
    
    ///  Set of params to control what data to get from a remote source Range, Filter etc
    var params: Params? { get }
}
