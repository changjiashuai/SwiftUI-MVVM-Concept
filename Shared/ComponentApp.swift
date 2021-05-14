//
//  LayoutApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI


@main
struct LayoutApp: App {
    
    /// Main view model
    @StateObject var viewModel = AppViewModel()
    
    /// The content and behavior of the app
    var body: some Scene {
        WindowGroup {
                ContentView(item: ItemFactory(), widget: WidgetFactory())
                .environmentObject(viewModel) //inject viewModel for to get access from every view in the hierarchy
        }
    }
}
