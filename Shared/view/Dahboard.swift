//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Service
import Ui

/// Main view
/// User list and User age chart share the same Store but introduce a different presentation for the data
struct Dahboard: View {

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel
   
    /// Amount of dynamically added charts
    @State private var count = 0
    
    /// Logger service
    @EnvironmentObject var logger: Logger
    
    /// Item view factory
    let buildItem: ItemFactory
    
    /// Widget view factory
    let buildWidget: WidgetFactory
    
    /// The type of view representing the body of this view.
    var body: some View {
        return VStack {
            BoardToolBar(count: $count)
            ScrollView(showsIndicators: false) {
                buildWidget.charts(
                    viewModel: viewModel,
                    factory: buildItem,
                    count: count
                )
                buildWidget.chart(
                    store: viewModel.users,
                    content: buildItem.userAgeBar,
                    toolBar: EmptyView()
                )
                buildWidget.list(
                    store: viewModel.users,
                    content: buildItem.userRow,
                    toolBar: ToolBar("Users")
                )
                buildWidget.chart(
                    store: viewModel.users,
                    content: buildItem.userAgeBar,
                    toolBar: ToolBar("Chart")
                )
                buildWidget.list(
                    store: viewModel.books,
                    content: buildItem.bookRow,
                    toolBar: ToolBar("Books")
                )
            }
        }.padding(5)
        .onAppear { logger.log("Dahboard is renered") }
    }
}
