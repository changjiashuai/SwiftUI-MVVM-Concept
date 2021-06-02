//
//  ComponentApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Service
import Ui

@main
struct ComponentApp: App {

    /// Authentication service
    @StateObject var auth = Authentication()

    /// Logger service
    @StateObject var logger = Logger()

    /// Main view model
    @StateObject var viewModel = AppViewModel()

    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            ZStack {
                EmptyData()
                SidebarView(
                    store: viewModel.menu
                )
                    .environmentObject(auth)
                    .environmentObject(logger)
                    .environmentObject(viewModel)

                if !auth.authenticated {
                    Launching()
                        .environmentObject(auth)
                        .environmentObject(logger)
                }
            }.onReceive(auth.$authenticated, perform: { value in
                if value {
                    viewModel.menu.load()
                }else{
                    viewModel.menu.removeAll()
                }
            })
        }
    }
}
