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

/// Chart View
/// `Controllable` - Add controllable behavior to view to obey commands from others views. Method `onCommandChanged` is implemented in Controllable
/// `Loadable` - Process load state of bound `Store`. Property `notLoading` is implemented in Loadable
/// `Selectable` - Add selection behavior for `View` items
/// `Componentable` - Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
/// `Scrolable` - Defines to represent scroll into `View`
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
