//
//  RemoveAllCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation
import Data

/// Command to temode all items from a store
class RemoveAllCommand: StoreCommand{
    
    /// Remode all items from a store
    /// - Parameter store: controlled store
    override func execute<T:Model, U: Proxy>(store : RemoteStore<T,U>){
        store.removeAll()
    }
}
