//
//  AgeChart.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import SwiftUI
import Data
import Ui
import Service

/// Chart displays data conformed to Model protocol
/// Method onCommandChanged is implemented in Controllable
/// Property notLoading is implemented in Loadable
struct BarChart<T: Model, U: Proxy, ToolBarContent : View, Content: View>: View, Controllable, Loadable, Selectable, BlueStylable, Componentable {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// Selected item
    @State var selectedItem: T?
    
    /// Template to define Item view
    let content: (T, Bool, CGFloat) -> Content
    
    /// ToolBar with set of controls
    let toolBar: ToolBarContent

    /// The type of view representing the body of this view
    var body: some View {
        VStack(spacing: 0){
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            controlRender()
        }
        .frame(height: 150)
        .mask(!notLoading, text: "Loading data for chart...")
        .onAppear { if notLoading { load() } }
    }
    
    // MARK: - API Methods
    
    /// Get Item width
    /// - Parameter proxy: Geometry reader proxy
    /// - Returns: Width for an item
    private func getItemWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / CGFloat(store.count()) - 16.0
    }
    
    /// Get chart View
    /// - Returns: chart
    @ViewBuilder
    func buildComponentBody() -> some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(store.items, id: \.self) { item in
                    content(item, isSelected(item), getItemWidth(proxy))
                        .onTapGesture { select(item) }
                }
            }.frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    /// Select item
    /// - Parameter item: selected item
    func select(_ item: T) { selectedItem = item }
}
