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
    
    /// The type of view representing the body of this view.
    var body: some View {
        VStack {
            getMainToolbar()
            ScrollView {
                UniversalList(
                    content: userFactory,
                    store: viewModel.users,
                    toolBar: ToolBar("Users", getExtraUserStoreControls)
                )
                AgeChart(
                    store: viewModel.users,
                    content: userAgeChartFactory,
                    toolBar: EmptyView()
                )
                AgeChart(
                    store: viewModel.users,
                    content: userAgeChartFactory,
                    toolBar: ToolBar<EmptyView>()
                )
                UniversalList(
                    content: bookFactory,
                    store: viewModel.books,
                    toolBar: ToolBar<EmptyView>("Books")
                )
                getChartViews()
            }
        }.padding()
    }
    
    /// Get custom user store controls
    /// - Returns: Set of controls for the user store
    @ViewBuilder
    func getExtraUserStoreControls() -> some View{
        Button("get Users page 1", action: {
            viewModel.users.load(params: ["page" : "1"]) {
                print("do something after loading")
            }
        })
        Button("get Users page 2", action: {
            viewModel.users.load(params: ["page" : "2"]) {
                print("do something after loading")
            }
        })
    }

    /// Get tool bar
    /// - Returns: Toolbar view
    @ViewBuilder
    func getMainToolbar() -> some View {
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
                    toolBar: ToolBar<EmptyView>("Age chart \(id)"),
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
            Text("Name: \(user.name)").font(.system(size: 14, weight: .bold)).padding(3)
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
            Rectangle().overlay(Text("Author: \(book.author)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
            Rectangle().overlay(Text("Title: \(book.title)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
        }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.blue)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
