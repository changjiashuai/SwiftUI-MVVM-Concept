//
//  MainView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 01.06.2021.
//

import SwiftUI
import Service
import Ui

struct MainView: View, Stylable {

    @State var title: String
    @State var imageName: String
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif

    var body: some View {
        ZStack {
            #if os(iOS)
            VStack {
                MainToolBar(title: $title, image:  Image(systemName: imageName))
                    .padding(.top, horizontalSizeClass == .compact ? 88 : 65)
                AutoStack {
                        Dahboard(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                        Movies()
                    }
                }
                .background(backgroundRGB)
                .ignoresSafeArea()
            #elseif os(macOS)
                VStack {
                    MainToolBar(title: $title, image: Image(systemName: imageName))
                    HStack {
                        Dahboard(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                        Movies()
                    }
                }
            #endif
        }
        .background(backgroundRGB)
        
    }
}

