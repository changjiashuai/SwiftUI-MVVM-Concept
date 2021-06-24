//
//  Ganre.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Data
import Service
import Ui

/// Master list displays data conformed to Model protocol
///
/// `Controllable` - Add controllable behavior to view to obey commands from others views.
///  Method `onCommandChanged` is implemented in `Controllable`
///  Property `notLoading` is implemented in `Controllable`
/// `Selectable` - Add selection behavior for `View` items.
///  Method`isSelected` is defined in Selectable
/// `Componentable` - Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
/// `Scrolable` - Defines to represent scroll into `View`
struct Master<T: Model, U: Store, F: View, Content: View>:
    View, Controllable, Selectable, Stylable, Componentable, Scrolable
{
    typealias Item = T  
    
    /// Store with data
    @StateObject var store: U
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// Logger service
    @EnvironmentObject var logger: Logger
    
    /// Selected item
    @State var selectedItem: T?
    
    /// A view builder that creates the content of an Item view
    let content: (T, Bool) -> Content
    
    /// ToolBar with set of controls
    let toolBar: F
    
    /// Current command
    @Binding var curentCommand: StoreCommand?
    
    /// The type of view representing the body of this view
    var body: some View {
        controlRender() /// Template method to call `buildComponentBody` definition in `Componentable`
            .mask(!notLoading)
            .onAppear {
                if notLoading {
                    load()
                    curentCommand = StoreCommand(.delete)
                }
            }
    }
    
    // MARK: - API Methods
    
    /// Get list View
    /// - Returns: list view
    @ViewBuilder
    func buildComponentBody() -> some View {
        VStack(spacing: 0) {
            ForEach(store.items, id: \.self) { item in
                content(item as! T, isSelected(item as! T))
                    .onTapGesture { select(item as! T) }
            }
        }
    }
    
    /// Select item
    /// - Parameter item: selected item
    func select(_ item: T) {
        selectedItem = item
        loadDetails(item)
    }
    
    // MARK: - Private Methods
    
    /// Load detail store for a master item
    /// - Parameter item: current master item
    private func loadDetails(_ item: T) {
        
        let command = StoreCommand(.read,
                                   params: [
                                    "page": "*",
                                    "masterId": "\(item.id)"
                                   ])
        
        curentCommand = authentication.tokenize(command)
    }
}
