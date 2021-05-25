//
//  BoardToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui

struct BoardToolBar: View, BlueStylable {

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
                .font(.system(size: 12, weight: .thin))
                .padding()
                .border(borderRGB)
                .background(backgroundRGB)
            ProgressView(value: Float(count) / Float(maxCol))
        }
    }
}
