//
//  LayoutApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Service
import Ui

@main
struct LayoutApp: App, BlueStylable {

    /// Main view model
    @StateObject var viewModel = AppViewModel()

    /// Authentication service
    @StateObject var auth = Authentication()

    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            if auth.authenticated {
                VStack {
                    MainToolBar()
                    HStack {
                        ContentView(
                            buildItem: ItemFactory(),
                            buildWidget: WidgetFactory()
                        )
                        Movies()
                    }.environmentObject(viewModel)
                }.environmentObject(auth)
                 .background(backgroundRGB)
            } else {
                Launching().environmentObject(auth)
            }
        }
    }
}
