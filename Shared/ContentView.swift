//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI

/// Main view
/// Users list and Users age chart share the same Store but introduce a different presentation for the data
struct ContentView: View {

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel

    /// Amount of dynamically added charts
    @State private var count = 0
    
    /// Item view factory
    let itemFactory: ItemFactory
    
    /// Widget view factory
    let widgetFactory: WidgetFactory
    
    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            MainToolBar(count: $count)
            ScrollView {
                widgetFactory.getList(
                    store: viewModel.users,
                    content: itemFactory.user,
                    toolBar: ToolBar("Users"){
                        Button("do something", action: { print("do something")})
                    }
                )
                widgetFactory.getChart(
                    store: viewModel.users,
                    content: itemFactory.userAgeBar,
                    toolBar: EmptyView()
                )
                widgetFactory.getChart(
                    store: viewModel.users,
                    content: itemFactory.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Chart")
                )
                widgetFactory.getList(
                    store: viewModel.books,
                    content: itemFactory.book,
                    toolBar: ToolBar<EmptyView>("Books")
                )
                widgetFactory.getCharts(
                    viewModel: viewModel,
                    factory: itemFactory,
                    count: count
                )
            }
        }.padding()
    }
}
