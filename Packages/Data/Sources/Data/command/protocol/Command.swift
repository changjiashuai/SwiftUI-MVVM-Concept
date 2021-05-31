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
    
    /// Optinal closure type for a collback
    typealias CallbackClosure = () -> Void
    
    /// Set of params
    var params: Params? { get }
    
    /// Do something after loading
    var callback: CallbackClosure? { get }
    
    /// Time stamp to differ repeating the same command several times in a row
    var date : Date { get }
    
    /// Execute a command for a store
    /// - Parameter store: controlled store
    func execute<T:Store>(store : T)
}

public extension Command{
    /// Compare values for equality or inequality
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: Returns a Boolean value indicating whether two values are equal
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.date == rhs.date
    }
}



