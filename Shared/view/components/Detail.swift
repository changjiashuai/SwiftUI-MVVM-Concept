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
struct Detail<T: Model, U: Proxy, ToolContent: View, Content: View>: View, Controllable, Loadable, BlueStylable, Componentable, Scrolable
{
    /// Store with data
    @StateObject var store: RemoteStore<T, U>

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// A view builder that creates the content of an Item view
    let content: (T) -> Content

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
        }.mask(!notLoading || masterIsLoading)
    }

    // MARK: - Methods

    /// Get list View
    /// - Returns: list view
    @ViewBuilder
    func buildComponentBody() -> some View {
        VStack(spacing: 0) {
            ForEach(store.items, id: \.self) { item in
                content(item)
            }
        }
    }
}
