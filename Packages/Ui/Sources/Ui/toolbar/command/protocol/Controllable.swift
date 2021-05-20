//
//  StoredView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation
import Data
import Service

/// Add controllable behavior to view to obey commands from others views
public protocol Controllable{
    
    associatedtype Item: Model
    associatedtype AbstractProxy: Proxy
    associatedtype AbstractAuthentication: AuthenticationAPI
    
    /// Store with data
    var store: RemoteStore<Item, AbstractProxy> {get}
    
    /// Authentication service
    var authentication: AbstractAuthentication  {get}
}

extension Controllable{
    
    /// Act on a command from the ToolBar
    /// - Parameter command: Command from toolBar to do some actions
    public func onCommandChanged(_ command: StoreCommand) {
        command.execute(store: store)
    }
    
    /// load data
    public func load() {
        ///Using authentication service generate secret token to prove level of access to communicate with remote sources
        store.load(params: ["page": "*", "access token": authentication.getToken()]) {
            print("🟦 do something after loading")
        }
    }
}

