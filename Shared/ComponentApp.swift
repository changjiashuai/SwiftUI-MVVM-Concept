//
//  ComponentApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Service
import Ui

@main
struct ComponentApp: App, BlueStylable {

    /// Main view model
    @StateObject var viewModel = AppViewModel()

    /// Authentication service
    @StateObject var auth = Authentication()

    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            if auth.authenticated {
                ZStack {
                    #if os(iOS)
                    Rectangle().ignoresSafeArea().background(backgroundRGB)
                    #endif
                    VStack {
                        MainToolBar()
                        #if os(iOS)
                            AutoStack {
                                ContentView(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                                Movies()
                            }.environmentObject(viewModel)
                        #elseif os(macOS)
                            HStack {
                                ContentView(buildItem: ItemFactory(), buildWidget: WidgetFactory())
                                Movies()
                            }.environmentObject(viewModel)
                        #endif
                    }
                        .environmentObject(auth)
                        .background(backgroundRGB)
                }
            } else {
                Launching().environmentObject(auth)
            }
        }
    }
}
