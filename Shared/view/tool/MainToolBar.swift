//
//  MainToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import SwiftUI
import Service
import Ui

/// Main tool bar of the app
struct MainToolBar: View, Stylable {

    /// Authentication service
    @EnvironmentObject var auth: Authentication
    
    @Binding var title : String

    /// The type of view representing the body of this view
    var body: some View {
        HStack {
            HStack(spacing: 0) {
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderRGB, lineWidth: 1))
                    .frame(width: 33, height: 33)
                    .padding(5)
                Text("\(auth.getAuthenticatedUserName())")
                    .padding(.trailing, 15)
            }
            .background(componentRGB)
            Text("\(title) analytical dashboard")
                .padding(.leading, 5)
                .font(.system(size: 21, weight: .thin))
                .lineLimit(1)
            Spacer()
            Button("sign out") { auth.signOut() }.padding(.horizontal)
        }
            .font(.system(size: 12, weight: .thin))
            .foregroundColor(.white)
            .border(borderRGB)
            .background(backgroundRGB)
    }
}