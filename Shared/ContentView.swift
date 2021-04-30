//
//  ContentView.swift
//  Shared
//
//  Created by Igor Shelopaev on 19.04.2021.
//

import SwiftUI

/// Main view contains two lists of Users loaded from the same store and Books
/// Users list and Users ages chart  share the same Store
struct ContentView: View {

    let viewModel: AppViewModel
    
    var body: some View {
        VStack {
            UniversalList(
                store: viewModel.users,
                content: { user in userFactory(user) },
                title: "Users"
            ).border(Color.white)
            UniversalList(
                store: viewModel.books,
                content: { book in bookFactory(book) },
                title: "Books"
            ).border(Color.white)
            AgeChart(
                store: viewModel.users,
                content: { user in userAgeChartFactory(user) },
                title: "Users age chart"
            ).border(Color.white)
            Spacer()
        }.padding()
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
            .overlay(Text(label).offset(y: -15),alignment: .topLeading)
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
        ContentView(viewModel: AppViewModel())
    }
}
