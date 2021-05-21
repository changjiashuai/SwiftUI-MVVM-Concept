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
struct Master<T: Model, D: Model, V: Proxy, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, Selectable {

    /// Store with data
    @StateObject var store: RemoteStore<T, U>

    /// Store with data
    @StateObject var detail: RemoteStore<D, V>

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// A view builder that creates the content of an Item view
    let content: (T, T?) -> Content

    /// ToolBar with set of controls
    let toolBar: ToolContent

    /// Selected item
    @State var selectedItem: T?

    /// The type of view representing the body of this view
    var body: some View {
        ZStack(alignment: .top) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            getList()
        }
            .frame(alignment: .topLeading)
            .mask(!notLoading)
            .border(Color.white)
            .onAppear { if notLoading { load(); detail.removeAll() } }
    }

    // MARK: - Methods

    /// Get list View
    /// - Returns: list view
    @ViewBuilder
    private func getList() -> some View {
        VStack(spacing: 5) {
            if store.error != nil { ErrorView(store.error!) }
            else {
                if store.items.count > 0 {
                    ForEach(store.items, id: \.self) { item in
                        content(item, selectedItem).onTapGesture { selectItem(item) }
                    }
                } else { EmptyData() }
            }
        }
            .offset(y: 50)
            .frame(maxHeight: .infinity, alignment: .topLeading)
    }


    /// Set curently selected item
    /// - Parameter item: selected item
    private func selectItem(_ item: T) {
        selectedItem = item

        detail.load(params: ["page": "*", "access token": authentication.getToken(), "masterId": "\(item.id)"], callback: { print("🟦 do something") })
    }
}
