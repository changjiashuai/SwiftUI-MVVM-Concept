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
                    MainToolBar().environmentObject(auth)
                    HStack {
                        ContentView(item: ItemFactory(), widget: WidgetFactory())
                            .environmentObject(auth)
                            .environmentObject(viewModel) //inject viewModel to get access to Stores from every view in the hierarchy
                        Movies()
                            .environmentObject(auth)
                            .environmentObject(viewModel)
                    }
                }
            } else {
                Launching().environmentObject(auth)
            }
        }
    }
}
