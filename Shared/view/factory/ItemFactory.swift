//
//  ItemFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 13.05.2021.
//

import SwiftUI
import Ui


/// Set of templates for items View
struct ItemFactory {

    /// Set of elementary elms for creating View
    let build: ElementBuilder

    // MARK: - Life circle

    init(_ build: ElementBuilder) { self.build = build }


    // MARK: - API Methods

    /// Create view template for defining User in the AgeChart
    /// - Parameter user: Set of data for User
    /// - Returns: View defining how User's age should be presented in the chart
    @ViewBuilder
    func userAgeBar(_ user: User, _ selected: User?, _ width: CGFloat) -> some View
    {
        let height = CGFloat(user.age)
        let label = "\(user.name) - \(user.age)"

        build.bar(label, width: width, height: height)
            .foregroundColor(user.id == selected?.id ? Color.purple : Color.green)
    }

    /// Create view template for defining User in the UniversalList
    /// - Parameter user: Set of data for User
    /// - Returns: View defining how User should be presented in the list
    @ViewBuilder
    func user(_ user: User, _ selected: User?) -> some View
    {
        build.row("Name: \(user.name)")
            .foregroundColor(user.id == selected?.id ? Color.purple : Color.orange)
    }

    /// Create view template for defining Book in the UniversalList
    /// - Parameter book: Set of data for Book
    /// - Returns: View defining how Book should be presented in the list
    @ViewBuilder
    func book(_ book: Book, _ selected: Book?) -> some View
    {
        build.row(["Author: \(book.author)", "Title: \(book.title)"])
            .foregroundColor(book.id == selected?.id ? Color.pink : Color.blue)
    }

}
