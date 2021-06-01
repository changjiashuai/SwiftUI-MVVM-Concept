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

    /// Main view model
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        ZStack {
            #if os(iOS)
                AutoStack {
                    VStack {
                        MainToolBar(title: $title)
                        Dahboard(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                        Movies()
                    } .padding(.top, 25)
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

