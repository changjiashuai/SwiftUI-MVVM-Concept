//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI
import Ui

/// Main view
/// User list and User age chart share the same Store but introduce a different presentation for the data
struct ContentView: View {

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel
   
    /// Amount of dynamically added charts
    @State private var count = 0
    
    /// Item view factory
    let buildItem: ItemFactory
    
    /// Widget view factory
    let buildWidget: WidgetFactory
    
    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            BoardToolBar(count: $count)
            ScrollView {
                buildWidget.charts(
                    viewModel: viewModel,
                    factory: buildItem,
                    count: count
                )
                buildWidget.list(
                    store: viewModel.users,
                    content: buildItem.userRow,
                    toolBar: ToolBar("Users"){
                        Button("do something", action: { print("🟦 do something")})
                    }
                )
                buildWidget.chart(
                    store: viewModel.users,
                    content: buildItem.userAgeBar,
                    toolBar: EmptyView()
                )
                buildWidget.chart(
                    store: viewModel.users,
                    content: buildItem.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Chart")
                )
                buildWidget.list(
                    store: viewModel.books,
                    content: buildItem.bookRow,
                    toolBar: ToolBar<EmptyView>("Books")
                )
            }
        }.padding()
         .frame(minWidth: 580)
    }
}
