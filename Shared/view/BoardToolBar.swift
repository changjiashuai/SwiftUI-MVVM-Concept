//
//  BoardToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI

struct BoardToolBar: View {

    ///Max amount of charts
    private let maxCol = 100

    /// Current amount of dynamic charts
    @Binding var count: Int

    /// The type of view representing the body of this view
    var body: some View {
        HStack {
            if count < maxCol { Button("+ chart \(count)") { count += 1 } }
            Spacer()
            if count != 0 { Button("- chart  \(count)") { count -= 1 } }
        }
    }
}
