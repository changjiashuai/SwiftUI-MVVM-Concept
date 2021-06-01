//
//  CommandType.swift
//  
//
//  Created by Igor Shelopaev on 01.06.2021.
//

import Foundation


/// Type of an action to perfome
public enum CommandType {

    case create
    
    case read
    
    case update
    
    case delete

    /// do nothing for a default state
    case idle
}
