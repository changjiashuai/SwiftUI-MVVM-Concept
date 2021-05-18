//
//  MainToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import SwiftUI
import Service

/// Main tool bar of the app
struct MainToolBar: View {
    
    /// Authentication service
    @EnvironmentObject var auth: Authentication
    
    ///Max amount of charts
    private let maxCol = 100
    
    /// Current amount of dynamic charts
    @Binding var count: Int
   
    /// The type of view representing the body of this view
    var body: some View {
        HStack {
            Text("Name: \(auth.getAuthenticatedUserName())")
            if count < maxCol { Button("+ chart \(count)") { count += 1 } }
            Spacer()
            if count != 0 { Button("- chart  \(count)") { count -= 1 } }
            Button("sign out") { auth.signOut() }
        }
    }
}
