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
    
    /// Type of action to perfome
    var type: CommandType { get }
   
    /// Time stamp to differ repeating the same command several times in a row
    var date : Date { get }
    
    /// Execute a command for a store
    /// - Parameter store: controlled store
    func execute<T:Store>(store : T)
    
    /// Copy the command
    func copy(with : Params?) -> Self

    /// Initilizer
    init (_ type: CommandType, params: Params?, date : Date)
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
    func copy(with params : Params?) -> Self {
        
        if self.params == nil {
            return Self( self.type, params: params, date: self.date )
        }
        
        var current = self.params
        current?.merge(params ?? [:]) { (_, new) in new }
        
        return Self( self.type, params: current, date: self.date )
        
    }
}



