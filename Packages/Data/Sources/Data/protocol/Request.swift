//
//  Request.swift
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Defines specs for a request
public protocol Request {
    
    ///  Set of params to control what data to get from a remote source Range, Filter etc
    var params: [String: String]? { get set }
}
