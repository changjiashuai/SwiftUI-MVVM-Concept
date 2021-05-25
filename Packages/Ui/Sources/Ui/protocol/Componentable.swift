//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI
import Data

public protocol Componentable{
    
    associatedtype Template : View
    
    associatedtype AbstractStore: Store
    
    /// Repository with data
    var store: AbstractStore { get }
    
    func buildComponentBody() -> Template
}

public extension Componentable{
    
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
