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
/// Method onCommandChanged is implemented in Controllable
/// Property notLoading is implemented in Loadable
struct UniversalList<T: Model, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, Selectable, BlueStylable {

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
            if store.count() > 0 {
                ScrollView {
                    getList()
                }
            } else {
                if store.error != nil { ErrorView(store.error!) }
                else { EmptyData() }
            }
        }.frame(height: 150, alignment: .topLeading)
            .mask(!notLoading)
            .border(componentBorderRGB)
            .background(componentRGB)
            .onAppear { if notLoading { load() } }
    }

    // MARK: - Methods

    /// Get list View
    /// - Returns: list view
    @ViewBuilder
    private func getList() -> some View {
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
