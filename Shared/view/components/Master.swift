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
struct Master<T: Model, D: Model, V: Proxy, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, Selectable, BlueStylable, Componentable, Scrolable {
    
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
    
    /// Indicates master Store loading
    @Binding var masterIsLoading: Bool
        
    /// The type of view representing the body of this view
    var body: some View {
        VStack(spacing: 0) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            controlRender()
            StatusBar(total: $store.total)
        }
        .mask(!notLoading)
        .onReceive(store.$loading, perform: onLoadingChange)
        .onAppear { if notLoading { load(); detail.removeAll() } }
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
    func select(_ item: T) {
        selectedItem = item
        loadDetails(item)
    }
    
    // MARK: - Private Methods
    
    /// Process master Store loading
    /// - Parameter loading: loading indicator
    private func onLoadingChange(_ loading: Bool){
        if loading {
            masterIsLoading = true
        }else{
            masterIsLoading = false
        }
    }

    /// Load detail store for a master item
    /// - Parameter item: current master item
    private func loadDetails(_ item: T){
        detail.load(params: ["page": "*", "access token": authentication.getToken(), "masterId": "\(item.id)"], callback: {masterIsLoading = false; print("🟦 do something") })
    }
}
