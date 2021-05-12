//
//  StoredView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation


/// Add controllable behavior to view to obey commands from others views
protocol Controllable{
    
    associatedtype Item: Model
    associatedtype AbstractProxy: Proxy
    
    /// Store with data
    var store: RemoteStore<Item, AbstractProxy> {get}
    
}


extension Controllable{
    
    /// Act on a command from the ToolBar
    /// - Parameter command: Command from toolBar to do some actions
    func onCommandChanged(_ command: StoreCommand) {
        command.execute(store: store)
    }
    
    /// load data
    func load() {
        store.load(params: ["page": "*"]) {
            print("do something after loading")
        }
    }
}

