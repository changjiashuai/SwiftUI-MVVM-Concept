//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation


/// Defines command for store from a UI control
class StoreCommand: Command, Equatable {
    static func == (lhs: StoreCommand, rhs: StoreCommand) -> Bool {
        lhs.date == rhs.date
    }
   
    /// Time stamp to differ repeating the same command several times in a row
    let date = Date()
    
    func execute<T:Model, U: Proxy>(store : RemoteStore<T,U>){
        
    }
}
