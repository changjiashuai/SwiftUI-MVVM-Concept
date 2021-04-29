//
//  LayoutApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI


@main
struct LayoutApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: AppViewModel())
        }
    }
}
