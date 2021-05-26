//
//  LaunchingView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import SwiftUI
import Service
import Ui

/// This view is presented while the app is launching, i.e. determining if a user is signed in.
struct Launching: View, BlueStylable {

    /// Authentication service
    @EnvironmentObject var authentication: Authentication

    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            Spacer()
            Image("dashboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("Click to launch") { authentication.signIn() }
            Spacer()
        }.frame(width: 1024)
        .frame(minWidth: 1024, idealWidth: 1024, maxWidth: .infinity, minHeight: 768, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(backgroundRGB)
    }
}
