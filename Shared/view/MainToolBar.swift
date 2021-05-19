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

    /// The type of view representing the body of this view
    var body: some View {
        HStack {
            Text("Name: \(auth.getAuthenticatedUserName())").font(.system(.headline)).padding()
            Spacer()
            Button("sign out") { auth.signOut() }.padding(.horizontal)
        }.background(Color.gray)
    }
}
