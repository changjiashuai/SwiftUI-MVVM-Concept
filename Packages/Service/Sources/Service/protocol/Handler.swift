//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 28.05.2021.
//

import Foundation


/// Chek the right to execute a command
public protocol Handler {
    
    /// The handler of the right to execute a command
    func handle() -> HandlerError?
}
