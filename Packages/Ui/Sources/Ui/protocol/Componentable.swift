//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI
import Data


/// Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
public protocol Componentable{
    
    associatedtype AbstractView: View
    
    associatedtype Template : View
    
    /// Store is a repo that maneges models conformed to Model protocol
    associatedtype AbstractStore: Store
    
    var toolBar: AbstractView { get }
    
    /// Repository with data
    var store: AbstractStore { get }    
   
    /// build component body
    func buildComponentBody() -> Template
    
    /// Act on a command from the ToolBar
    /// - Parameter command: Command from toolBar to do some actions
     func onCommandChanged(_ command: StoreCommand)
}

public extension Componentable{    
    
    /// Define component body depends on a request results
    /// - Returns: Component body
    @ViewBuilder
    func controlRender() -> some View{
        toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)        
        if store.count() > 0 {
            if self is Scrolable { ScrollView() { buildComponentBody() } }
            else { buildComponentBody() }
        } else {
            if store.error != nil { ErrorView(store.error!) }
            else { EmptyData() }
        }
    }
}
