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
///
/// `Controllable` - Add controllable behavior to view to obey commands from others views.
///  Method `onCommandChanged` is implemented in `Controllable`
///  Property `notLoading` is implemented in `Controllable`
/// `Selectable` - Add selection behavior for `View` items.
///  Method`isSelected` is defined in Selectable
/// `Componentable` - Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
/// `Scrolable` - Defines to represent scroll into `View`

struct BarChart<U: Store, V : View, Content: View>: View, Controllable, Selectable, Stylable, Componentable
{
    
    typealias Item = U.Item
    
    /// Store with data
    @StateObject var store: U
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// Logger service
    @EnvironmentObject var logger: Logger
    
    /// Selected item
    @State var selectedItem: Item?
    
    /// Template to define Item view
    let content: (Item, Bool, CGFloat) -> Content
    
    /// ToolBar with set of controls
    let toolBar: V
    
    /// The type of view representing the body of this view
    var body: some View {
        controlRender() /// Template method to call `buildComponentBody` definition in `Componentable`
            .frame(height: 160)
            .mask(!notLoading, text: "Loading data for chart...")
            .onAppear {
                if notLoading { load() }
            }
    }
    
    // MARK: - API Methods
    
    /// Get Item width
    /// - Parameter proxy: Geometry reader proxy
    /// - Returns: Width for an item
    private func getItemWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / CGFloat(store.count()) - 11.0
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
            .clipped()
        }
    }
    
    /// Select item
    /// - Parameter item: selected item
    func select(_ item: Item) { selectedItem = item }
}
