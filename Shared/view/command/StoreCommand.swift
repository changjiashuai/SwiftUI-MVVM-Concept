//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation


/// Defines command for store from a UI control
struct StoreCommand: Command {
    
    /// type of command for a store
    let type : StoreCommandType
    
    //time stamp to differ repeating the same command several times in a row
    let date = Date()
}
