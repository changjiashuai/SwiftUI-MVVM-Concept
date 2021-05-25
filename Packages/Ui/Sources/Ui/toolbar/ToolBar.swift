//
//  ToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI
import Service


/// Toolbar for any View supporting StoredView protocol
public struct ToolBar<Content: View>: View, BlueStylable {

    /// Current command
    @State var curentCommand: StoreCommand = StoreCommand()

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// Title text
    let title: String?

    /// get rid off controls from the toolbar
    let showControls: Bool

    /// Set of extra controls to add to the default set
    let items: (() -> Content)?

    /// The type of view representing the body of this view
    public var body: some View {
        HStack {
            if title != nil {
                Text("\(title!)").frame(minWidth: 50).font(.system(size: 17, weight: .thin))
            }
            Spacer()
            if showControls {
                getItemsView()
                Button("update", action: {
                    curentCommand = LoadCommand(params: ["page": "*", "access token": authentication.getToken()], callback: { print("🟦 do something") })
                })
                Button("clear", action: {
                    curentCommand = RemoveAllCommand()
                })
            }
        }
            .padding(.horizontal, 5)
            .frame(height: 50)
            .font(.system(size: 12, weight: .thin))
            .background(backgroundRGB)
            .border(borderRGB)
            .preference(key: StoreCommandKey.self, value: curentCommand)

    }

    // MARK: - Life circle

    /// Initializer
    /// - Parameters:
    ///   - title: Text of title
    ///   - showControls: show set of controlls
    ///   - items: Additional items
    public init(_ title: String? = nil, showControls: Bool = true, _ items: (() -> Content)? = nil) {
        self.title = title
        self.showControls = showControls
        self.items = items
    }

    /// Initializer
    /// - Parameters:
    ///   - title: Text of title
    ///   - items: Additional items
    public init(_ title: String? = nil, _ items: (() -> Content)? = nil) {
        self.title = title
        self.items = items
        self.showControls = true
    }

    // MARK: - Methods

    /// Get View for extra controls
    /// - Returns: extra controls from config
    @ViewBuilder
    private func getItemsView() -> some View {
        if items != nil {
            HStack { items!() }.padding().background(componentBorderRGB)
                .border(width: 1, edges: [.leading,.trailing], color: borderRGB)
        } else {
            EmptyView()
        }
    }
}

