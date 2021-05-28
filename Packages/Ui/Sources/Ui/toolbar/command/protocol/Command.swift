//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 28.05.2021.
//

import Foundation
import Data


/// The Command protocol declares a method for executing a command.
protocol Command: Equatable{
    
    /// Execute a command for a store
    /// - Parameter store: controlled store
    func execute<T:Store>(store : T)
}

