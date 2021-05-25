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
/// Detail view is updated after am item is selected
/// Method onCommandChanged is implemented in Controllable
/// Property notLoading is implemented in Loadable
struct Master<T: Model, D: Model, V: Proxy, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, Selectable, BlueStylable, Componentable {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// Store with data
    @StateObject var detail: RemoteStore<D, V>
    
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
        }
        .mask(!notLoading)
        .onAppear { if notLoading { load(); detail.removeAll() } }
    }
    
    // MARK: - Methods
    
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
    func select(_ item: T) {
        
        selectedItem = item
        
        detail.load(params: ["page": "*", "access token": authentication.getToken(), "masterId": "\(item.id)"], callback: { print("🟦 do something") })
    }
}
