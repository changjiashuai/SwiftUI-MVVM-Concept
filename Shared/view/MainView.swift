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
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    /// Main view model
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        ZStack {
            #if os(iOS)
            VStack {
                MainToolBar(title: $title)
                    .padding(.top, horizontalSizeClass == .compact ? 88 : 45)
                AutoStack {
                        Dahboard(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                        Movies()
                    }
                }
                .background(backgroundRGB)
                .ignoresSafeArea()
            #elseif os(macOS)
                VStack {
                    MainToolBar(title: $title)
                    HStack {
                        Dahboard(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                        Movies()
                    }
                }
            #endif
        }
        .background(backgroundRGB)
        .environmentObject(viewModel)
    }
}

