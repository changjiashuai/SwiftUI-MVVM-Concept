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
    
    @State var image: Image
    
    /// The type of view representing the body of this view
    var body: some View {
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(width: 33, height: 33)
                .padding(5)
                .padding(.leading, 8)
            Text("\(title) analytical dashboard")                
                .font(.system(.title2))
                .lineLimit(1)
            Spacer()
            HStack(spacing: 0) {
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderRGB, lineWidth: 1))
                    .frame(width: 33, height: 33)
                    .padding(5)
                    .padding(.leading, 15)
                Text("\(auth.getUserName())")
                    .padding(.trailing, 25)
            }
            .background(componentRGB)
        }
        .font(.system(.body))
            .foregroundColor(.white)
            .border(borderRGB)
            .background(backgroundRGB)
    }
}
