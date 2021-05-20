//
//  LayoutApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Service

@main
struct LayoutApp: App {

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
                        ContentView(item: ItemFactory(), widget: WidgetFactory())                            
                        Movies()
                    }.environmentObject(viewModel)
                }.environmentObject(auth)
            } else {
                Launching().environmentObject(auth)
            }
        }
    }
}
