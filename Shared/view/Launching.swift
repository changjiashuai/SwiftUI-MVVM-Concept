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
struct Launching: View, Stylable {
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            Spacer()
            if authentication.authenticated == false {
                Image("dashboard_title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(BarAnimation(), alignment: .center)
                    .padding(20)
            }
            Button("Click to launch") { authentication.signIn() }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(getInset())
        .foregroundColor(.white)
        .background(backgroundRGB)
        .ignoresSafeArea()
    }
    
    
    /// Get Inset
    /// - Returns: Inset
   private func getInset() -> CGFloat {
        #if os(iOS)
        return 25.0
        #else
        return 102.0
        #endif
    }
}
