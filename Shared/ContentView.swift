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
    @State private var col = 0

    ///Max amount of charts
    private let maxCol = 100

    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            getMainToolbar()
            ScrollView {
                UniversalList(
                    store: viewModel.users,
                    content: ItemFactory.user,
                    toolBar: ToolBar("Users", getExtraToolBarControls)
                )
                AgeChart(
                    store: viewModel.users,
                    content: ItemFactory.userAgeBar,
                    toolBar: EmptyView()
                )
                AgeChart(
                    store: viewModel.users,
                    content: ItemFactory.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Chart")
                )
                UniversalList(
                    store: viewModel.books,
                    content: ItemFactory.book,
                    toolBar: ToolBar<EmptyView>("Books")
                )
                getChartViews()
            }
        }.padding()
            .frame(minWidth: 522)
    }


    /// Get extra controls for a tool bar
    /// - Returns: Set of controls
    @ViewBuilder
    private func getExtraToolBarControls() -> some View {
        Button("do something", action: {
            print("do something")
        })
    }

    /// Get tool bar
    /// - Returns: Toolbar view
    @ViewBuilder
    private func getMainToolbar() -> some View {
        HStack {
            if col < maxCol { Button("+ chart \(col)") { col += 1 } }
            Spacer()
            if col != 0 { Button("- chart  \(col)") { col -= 1 } }
        }
    }

    /// Get  charts
    /// - Returns: Chart views
    @ViewBuilder
    private func getChartViews() -> some View {
        if col == 0 { EmptyView() } else {
            ForEach(1...col, id: \.self) { id in
                AgeChart(
                    store: viewModel.getFileJsonStore(from: "user_chart.json"),
                    content: ItemFactory.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Age chart \(id)")
                )
            }
        }
    }
}
