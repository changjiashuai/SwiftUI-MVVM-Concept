//
//  UniversalList.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import SwiftUI
import Data
import Service
import Ui

/// List displays data conformed to Model protocol
/// Controllable - Add controllable behavior to view to obey commands from others views. Method onCommandChanged is implemented in Controllable
/// Loadable - Process load state of bound `Store`. Property notLoading is implemented in Loadable
/// Selectable - Add selection behavior for `View` items
/// Componentable - Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
/// Scrolable - Defines to represent scroll into `View`
struct UniversalList<T: Model, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, Selectable, BlueStylable, Componentable, Scrolable {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// Selected item
    @State var selectedItem: T?
    
    /// A view builder that creates the content of an Item view
    let content: (T, Bool) -> Content
    
    /// ToolBar with set of controls
    let toolBar: ToolContent    
    
    /// The type of view representing the body of this view
    var body: some View {
        
        VStack(spacing: 0) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            controlRender()
            StatusBar(total: $store.total)
        }
        .frame(height: 150)
        .mask(!notLoading)
        .onAppear { if notLoading { load() } }
    }
    
    // MARK: - API Methods
    
    /// Get list View
    /// - Returns: list view
    @ViewBuilder
    func buildComponentBody() -> some View {
        VStack(spacing: 0) {
            ForEach(store.items, id: \.self) { item in
                content(item, isSelected(item))
                    .onTapGesture { select(item) }
            }
        }
    }
    
    /// Select item
    /// - Parameter item: selected item
    func select(_ item: T) { selectedItem = item }
}
