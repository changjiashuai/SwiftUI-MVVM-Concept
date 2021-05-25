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
        ZStack(alignment: .topLeading) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            if store.count() > 0 {
                buildComponentBody()
            } else {
                if store.error != nil { ErrorView(store.error!) }
                else { EmptyData() }
            }
        }
        .frame(height: 150, alignment: .topLeading)
        .mask(!notLoading, text: "Loading data for chart...")
        .border(width: 1, edges: [.leading, .bottom], color: selectedRGB)
        .border(width: 1, edges: [.top, .trailing], color: borderRGB)
        .background(componentRGB)
        .onAppear { if notLoading { load() } }
    }
    
    // MARK: - Methods
    
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
            }
            .offset(y: 50)
           .frame(height: 100, alignment: .bottomLeading)
        }
    }
    
    /// Select item
    /// - Parameter item: selected item
    func select(_ item: T) { selectedItem = item }
}
