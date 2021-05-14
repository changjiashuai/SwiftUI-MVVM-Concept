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
    @StateObject var vm = AppViewModel()
    
    /// Authentication service
    @StateObject var auth = Authentication()
    
    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
            if auth.authenticated {
                ContentView(item: ItemFactory(), widget: WidgetFactory())
                    .environmentObject(auth)
                    .environmentObject(vm) //inject viewModel to get access to Stores from every view in the hierarchy
            } else {
                Launching().environmentObject(auth)
            }
        }
    }
}
