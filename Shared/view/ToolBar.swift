//
//  ToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI



/// Toolbar for any View supporting StoredView protocol
struct ToolBar: AbstractToolBar {

    /// Title text
    let title: String?

    init(_ title: String?) {
        self.title = title
    }

    /// State of toolbar
    @State var curentCommand: StoreCommand = StoreCommand(type: .idle)

    var body: some View {
        HStack {
            if title != nil {
                Text("\(title!)")
            }
            Spacer()
            Button("update", action: {
                curentCommand = StoreCommand(type: .load)
            })
            Button("clear", action: {
                curentCommand = StoreCommand(type: .removeAll)
            })
        }
            .foregroundColor(.black)
            .padding(.horizontal, 5)
            .frame(height: 50).background(Color.gray)
            .preference(key: StoreCommandKey.self, value: curentCommand)
    }
}

struct StoreCommandKey: PreferenceKey {
    static let defaultValue: StoreCommand = StoreCommand(type: .idle)
    static func reduce(value: inout StoreCommand, nextValue: () -> StoreCommand) {
        value = nextValue()
    }
}
