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
    
    associatedtype Template : View
    
    /// Store is a repo that maneges models conformed to Model protocol
    associatedtype AbstractStore: Store
    
    /// Repository with data
    var store: AbstractStore { get }
    
    /// build component body
    func buildComponentBody() -> Template
}

public extension Componentable{
    
    /// Define component body depends on a request results
    /// - Returns: Component body
    @ViewBuilder
    func controlRender() -> some View{
        if store.count() > 0 {
            ScrollView {
                buildComponentBody()
            }
        } else {
            if store.error != nil { ErrorView(store.error!) }
            else { EmptyData() }
        }
    }
}
