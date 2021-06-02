//
//  BoardToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui


/// Toolbar for managing the dynamic charts
struct BoardToolBar: View, Stylable {

    ///Max amount of charts
    private let maxCol = 15

    /// Current amount of dynamic charts
    @Binding var count: Int

    /// The type of view representing the body of this view
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    if count > 0 {
                        Text("\(count)")
                    }
                }.frame(width: 25)
                if count < maxCol { Button("Add chart") { count += 1 } }
                Spacer()
                if count != 0 { Button("Remove chart") { count -= 1 } }
            }
            .font(.system(.body))
                .padding()
                .border(borderRGB)
                .background(backgroundRGB)
                .foregroundColor(.white)
            ProgressView(value: Float(count) / Float(maxCol))
        }
    }
}
