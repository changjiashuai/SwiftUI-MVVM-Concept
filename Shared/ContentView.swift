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

    @EnvironmentObject var viewModel: AppViewModel
    
    /// Amount of dynamically added charts
    @State var col = 0
    ///Max amount of charts
    let maxCol = 100

    var body: some View {
        ScrollView {
            VStack {
                UniversalList(
                    store: viewModel.users,
                    content: { user in userFactory(user) },
                    title: "Users"
                )
                AgeChart(
                    store: viewModel.users,
                    content: { user in userAgeChartFactory(user) },
                    title: "Users age chart"
                )
                UniversalList(
                    store: viewModel.books,
                    content: { book in bookFactory(book) },
                    title: "Books"
                )
                getToolbar()
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
    
    /// Get another chart
    /// - Returns: Chart view
    @ViewBuilder
    func getChartViews() -> some View {
        EmptyView()
        
        if col > 0 {
            ForEach(1...col, id: \.self) { id in
                AgeChart(
                    store: viewModel.getFileJsonStore("user.json"),
                    content: { user in userAgeChartFactory(user) },
                    title: "Users age chart \(id)",
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
    private func userAgeChartFactory(_ user: User) -> some View {
        let height = CGFloat(user.age)
        let label = "\(user.name) - \(user.age)"

        Rectangle().frame(width: 88, height: height)
            .foregroundColor(.green)
            .overlay(Text(label).offset(y: -15), alignment: .topLeading)
            .padding(.horizontal, 5)
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
