//
//  StatusBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 26.05.2021.
//

import SwiftUI
import Ui


/// Displays additional information for widgets
struct StatusBar: View, Stylable  {
    
    /// Total amount of items
    @Binding var total : Int

    /// The type of view representing the body of this view
    var body: some View {
        HStack{
            Text("Total items: \(total)")
                .foregroundColor(.white).font(.system(.caption))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(5)
        .padding(.leading, 11)
        .border(width: 1, edges: [.leading, .bottom], color: selectedRGB)
        .border(width: 1, edges: [.top, .trailing], color: borderRGB)
        .background(backgroundRGB)
    }
}
