//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation


/// Defines command for store from a UI control
class StoreCommand: Equatable {
    
    /// Time stamp to differ repeating the same command several times in a row
    let date = Date()
       
    /// execute method
    func execute<V:Model, U: Proxy>(store : RemoteStore<V,U>){}
    
    static func == (lhs: StoreCommand, rhs: StoreCommand) -> Bool {
        lhs.date == rhs.date
    }
}
