//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI

/// Main view contains two lists of Users loaded from the same store and Books
/// Users list and Users age chart  share the same Store
struct ContentView: View {

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel

    /// Amount of dynamically added charts
    @State var col = 0
    ///Max amount of charts
    let maxCol = 100

    var body: some View {
        VStack {
            getToolbar()
            ScrollView {
                UniversalList(
                    content: userFactory,
                    store: viewModel.users,
                    toolBar: ToolBar(title: "Users")                    
                )
                AgeChart(
                    store: viewModel.users,
                    content: userAgeChartFactory,
                    toolBar: ToolBar(title: "Age chart")
                )
                UniversalList(
                    content: bookFactory,
                    store: viewModel.books,
                    toolBar: ToolBar(title: "Books")
                )
                getChartViews()
            }
        }.padding()
    }

    /// Get tool bar
    /// - Returns: Toolbar view
    @ViewBuilder
    func getToolbar() -> some View {
        HStack {
            if col < maxCol { Button("+ chart \(col)") { col += 1 } }
            Spacer()
            if col != 0 { Button("- chart  \(col)") { col -= 1 } }
        }
    }

    /// Get  charts
    /// - Returns: Chart views
    @ViewBuilder
    func getChartViews() -> some View {
        if col == 0 { EmptyView() } else {
            ForEach(1...col, id: \.self) { id in
                AgeChart(
                    store: viewModel.getFileJsonStore(from: "user_chart.json"),
                    content: userAgeChartFactory,
                    toolBar: ToolBar(title: "Age chart \(id)"),
                    autoLoad: true
                )
            }
        }
    }

    /// ViewBuilder to create view template for defining User in the UniversalList
    /// - Parameter user: set of data for User
    /// - Returns: View defining how User should be presented in the list
    @ViewBuilder
    private func userFactory(_ user: User) -> some View {
        HStack {
            Text("Name: \(user.name)").font(.system(size: 14, weight: .bold))
        }
            .frame(maxWidth: .infinity)
            .background(Color.orange)
    }

    /// ViewBuilder to create view template for defining User in the AgeChart
    /// - Parameter user: set of data for User
    /// - Returns: View defining how User's age should be presented in the chart
    @ViewBuilder
    private func userAgeChartFactory(_ user: User, _ width: CGFloat) -> some View {
        let height = CGFloat(user.age)
        let label = "\(user.name) - \(user.age)"

        Rectangle().frame(width: width, height: height)
            .foregroundColor(.green)
            .overlay(Text(label).offset(y: -20), alignment: .topLeading)
            .padding(.horizontal, 8)
    }

    /// ViewBuilder to create view template for defining Book in the UniversalList
    /// - Parameter book: set of data for Book
    /// - Returns: View defining how Book should be presented in the list
    @ViewBuilder
    private func bookFactory(_ book: Book) -> some View {
        HStack {
            Text("Title: \(book.title)").font(.system(.headline))
            Text("Author: \(book.author)")
        }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
