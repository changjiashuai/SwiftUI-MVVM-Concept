//
//  ToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI
import Service
import Data

/// Toolbar for any View supporting StoredView protocol
public struct ToolBar: View, Stylable {

    /// Current command
    @State var curentCommand = StoreCommand(.idle)

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// Title text
    let title: String?

    /// get rid off controls from the toolbar
    let showControls: Bool

    /// The type of view representing the body of this view
    public var body: some View {
        HStack {
            if title != nil {
                Text("\(title!)").frame(minWidth: 50).font(.system(size: 17, weight: .thin))
            }
            Spacer()
            if showControls {
                Button("update", action: {
                    curentCommand = load()
                })
                Button("clear", action: {
                    curentCommand = removeAll()
                })
            }
        }
            .padding(.horizontal, 11)
            .frame(height: 50)
            .font(.system(size: 12, weight: .thin))
            .foregroundColor(.white)
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
    public init(_ title: String? = nil, showControls: Bool = true) {
        self.title = title
        self.showControls = showControls
    }


    // MARK: - Methods


    /// Create remove all command
    /// - Returns: Remove all command
    private func removeAll() -> StoreCommand {
        let command = StoreCommand(.delete)

        return authentication.tokenize(command)
    }

    /// Create load command
    /// - Returns: Load command
    private func load() -> StoreCommand {
        let command = StoreCommand( .read, params: [ "page": "*"] )

        return authentication.tokenize(command)
    }
}

