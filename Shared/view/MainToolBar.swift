//
//  MainToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import SwiftUI


/// Main tool bar of the app
struct MainToolBar: View {
    
    ///Max amount of charts
    private let maxCol = 100
    
    /// Current amount of dynamic charts
    @Binding var count: Int
    
    var body: some View {
        HStack {
            if count < maxCol { Button("+ chart \(count)") { count += 1 } }
            Spacer()
            if count != 0 { Button("- chart  \(count)") { count -= 1 } }
        }
    }
}
