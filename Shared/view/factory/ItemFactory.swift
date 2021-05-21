//
//  ItemFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 13.05.2021.
//

import SwiftUI


/// Set of templates for items View
struct ItemFactory {


    /// Create view template for defining User in the AgeChart
    /// - Parameter user: Set of data for User
    /// - Returns: View defining how User's age should be presented in the chart
    @ViewBuilder
    func userAgeBar(_ user: User, _ selected: User?,_ width: CGFloat) -> some View {
        let height = CGFloat(user.age)
        let label = "\(user.name) - \(user.age)"

        Rectangle().frame(width: width, height: height)
            .foregroundColor(user.id == selected?.id ? Color.yellow : Color.green)
            .overlay(Text(label).offset(y: -20), alignment: .topLeading)
            .padding(.horizontal, 8)
    }

    /// Create view template for defining User in the UniversalList
    /// - Parameter user: Set of data for User
    /// - Returns: View defining how User should be presented in the list
    @ViewBuilder
    func user(_ user: User, _ selected: User?) -> some View {
        HStack {
            Text("Name: \(user.name)").font(.system(size: 14, weight: .bold)).padding(3)
        }
            .frame(maxWidth: .infinity)
            .background(user.id == selected?.id ? Color.purple : Color.orange)
    }

    /// Create view template for defining Book in the UniversalList
    /// - Parameter book: Set of data for Book
    /// - Returns: View defining how Book should be presented in the list
    @ViewBuilder
    func book(_ book: Book, _ selected: Book?) -> some View {
        HStack {
            Rectangle().overlay(Text("Author: \(book.author)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
            Rectangle().overlay(Text("Title: \(book.title)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
        }
            .frame(maxWidth: .infinity)
            .foregroundColor(book.id == selected?.id ? Color.pink : Color.blue)
    }
}
