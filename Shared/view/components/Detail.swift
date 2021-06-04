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
///
/// `Controllable` - Add controllable behavior to view to obey commands from others views.
///  Method `onCommandChanged` is implemented in `Controllable`
///  Property `notLoading` is implemented in `Controllable`
/// `Selectable` - Add selection behavior for `View` items.
///  Method`isSelected` is defined in Selectable
/// `Componentable` - Template Method  is a behavioral design pattern defines the skeleton of an algorithm in the protocol but lets Structs implement specific steps of the algorithm without changing its structure.
/// `Scrolable` - Defines to represent scroll into `View`

struct Detail<T: Model, U: Proxy, V: View, Content: View>:
    View, Controllable, Stylable, Componentable, Scrolable
{
    /// Store with data
    @StateObject var store: RemoteStore<T, U>

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// Logger service
    @EnvironmentObject var logger: Logger

    /// A view builder that creates the content of an Item view
    let content: (T) -> Content

    /// ToolBar with set of controls
    let toolBar: V

    /// Current command
    @Binding var curentCommand: StoreCommand?

    /// The type of view representing the body of this view
    var body: some View {
        controlRender() /// Template method too call `buildComponentBody` definition in `Componentable`
            .mask(!notLoading)
            .preference(key: StoreCommandKey.self, value: curentCommand ?? StoreCommand(.idle))
            .onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
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
