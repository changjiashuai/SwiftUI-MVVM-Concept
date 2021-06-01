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

    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            if auth.authenticated {
                SidebarView()
                    .environmentObject(auth)
                    .environmentObject(logger)
            } else {
                Launching()
                    .environmentObject(auth)
            }
        }
    }
}
