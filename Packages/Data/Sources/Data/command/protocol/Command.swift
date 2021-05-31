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
    
    /// Copy the command
    func copy(with : Params?) -> Self

    /// Initilizer
    init (params: Params?, callback: CallbackClosure?, date : Date)
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
    
    /// Make a copy of the command
    /// - Parameter with: Copy with params
    /// - Returns: Copy of the  command
    func copy(with params : Params?) -> Self where Self : AnyObject{
        
        guard let _ = self.params else {
            return Self(params: params, callback: self.callback, date: self.date)
        }
        
        var current = self.params
        current?.merge(params ?? [:]) { (_, new) in new }
        
        return Self(params: current, callback: self.callback, date: self.date)
        
    }
}



