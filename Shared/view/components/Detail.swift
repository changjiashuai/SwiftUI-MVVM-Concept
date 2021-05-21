//
//  Movie.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Data
import Service
import Ui

/// Detail list displays data conformed to Model protocol
/// Method onCommandChanged is implemented in Controllable
/// Property notLoading is implemented in Loadable
struct Detail<T: Model, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable {

    /// Store with data
    @StateObject var store: RemoteStore<T, U>

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// A view builder that creates the content of an Item view
    let content: (T) -> Content

    /// ToolBar with set of controls
    let toolBar: ToolContent

    /// The type of view representing the body of this view
    var body: some View {
        ZStack(alignment: .top) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            getList()
        }.frame(alignment: .topLeading)
            .mask(!notLoading)
            .border(Color.white)
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
                        content(item)
                    }
                } else { EmptyData() }
            }
        }
            .offset(y: 50)
            .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
