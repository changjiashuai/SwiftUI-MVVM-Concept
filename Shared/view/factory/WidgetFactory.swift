//
//  WidgetFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import SwiftUI
import Data
import Ui

/// Set of widgets for the app
struct WidgetFactory {
    
    /// Get  charts
    /// - Returns: Chart views
    @ViewBuilder
    func getCharts(viewModel: AppViewModel, factory:ItemFactory, count: Int) -> some View {
        if count == 0 { EmptyView() } else {
            ForEach(1...count, id: \.self) { id in
                getChart(
                    store: viewModel.getFileJsonStore(from: "user_chart.json"),
                    content: factory.userAgeBar,
                    toolBar: ToolBar<EmptyView>("Age chart \(id)")
                )
            }
        }
    }
    
    /// Get  chart
    /// - Returns: Chart view
    @ViewBuilder
    func getChart<T:Model, U: Proxy, Content: View, ToolBarContent: View>(store: RemoteStore<T,U>, content: @escaping (T, CGFloat) -> Content, toolBar: ToolBarContent) -> some View {
        BarChart(
            store: store,
            content: content,
            toolBar: toolBar
        )
    }
    
    /// Get  list
    /// - Returns: List view
    @ViewBuilder
    func getList<T:Model, U: Proxy, Content: View, ToolBarContent: View>(store: RemoteStore<T,U>, content: @escaping (T) -> Content, toolBar: ToolBarContent) -> some View {
        UniversalList(
            store: store,
            content: content,
            toolBar: toolBar
        )
    }
}


