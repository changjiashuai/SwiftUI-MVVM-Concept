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
public protocol Controllable {
    
    associatedtype Item: Model
    associatedtype AbstractProxy: Proxy
    associatedtype AbstractAuthentication: AuthenticationAPI
    
    ///Dic for a request params
    typealias Params = [String: String]
    /// Optinal closure type for a collback
    typealias CallbackClosure = () -> Void
    
    /// Store with data
    var store: RemoteStore<Item, AbstractProxy> { get }
    
    /// Authentication service
    var authentication: AbstractAuthentication { get }
    
    /// Log service
    var logger: Logger { get }
    
    /// Chain of handlers to grant a right to execute a command
    func handle(_ command: StoreCommand) -> HandlerError?
}

extension Controllable {
    
    /// Indicates state of loading
    public var notLoading: Bool {
        !store.loading
    }
    
    /// Chain of handlers to grant a right to execute a command, log a command property etc
    /// - Returns: Error of the right to perfom a command
    public func handle(_ command : StoreCommand) -> HandlerError? {
        
        if let error = logger.handle(command){
            return error
        }
        
        return authentication.handle(command)
    }
    
    /// Act on a command from the ToolBar
    /// - Parameter command: Command from toolBar to do some actions
    public func onCommandChanged(_ command: StoreCommand) {
        guard let error = handle(command) else{
            return command.execute(store: store)
        }
        
        //Display an error in the view that requested to run a command
        store.error = error.description
    }
    
    /// load data
    public func load( params : Params = [:], callback : CallbackClosure? = nil ){
        
        var all = [ "access token" : authentication.getToken()]
        for (key, value) in params { all[key] = value }
        
        onCommandChanged(
            LoadCommand(params: all, callback: callback)
        )
    }
}

