//
//  LayoutApp.swift
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI


@main
struct LayoutApp: App {

    @StateObject var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            HStack {
                ContentView()
                //inject viewModel for to get access from every view in the hierarchy
                .environmentObject(viewModel)
            }
        }
    }
}
