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
    @EnvironmentObject var vm: AppViewModel

    /// Amount of dynamically added charts
    @State private var count = 0
    
    /// Item view factory
    let item: ItemFactory
    
    /// Widget view factory
    let widget: WidgetFactory
    
    /// The type of view representing the body of this view
    var body: some View {
        VStack {
            MainToolBar(count: $count)
            ScrollView {
                widget.getList(
                    store: vm.users,
                    content: item.user,
                    toolBar: ToolBar("Users"){
                        Button("do something", action: { print("do something")})
                    }
                )
                widget.getChart(
                    store: vm.users,
                    content: item.userAgeBar,
                    toolBar: EmptyView()
                )
                widget.getChart(
                    store: vm.users,
                    content: item.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Chart")
                )
                widget.getList(
                    store: vm.books,
                    content: item.book,
                    toolBar: ToolBar<EmptyView>("Books")
                )
                widget.getCharts(
                    viewModel: vm,
                    factory: item,
                    count: count
                )
            }
        }.padding()
         .frame(minWidth: 522)
    }
}
