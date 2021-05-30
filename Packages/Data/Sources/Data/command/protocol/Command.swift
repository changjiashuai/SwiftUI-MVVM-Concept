//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 28.05.2021.
//

import Foundation


/// The Command protocol declares a method for executing a command.
public protocol Command: Equatable{
       
    ///Dic for a request params
    typealias Params = [String: String]
    
    /// Set of params
    var params: Params? { get }
    
    /// Execute a command for a store
    /// - Parameter store: controlled store
    func execute<T:Store>(store : T)
}

