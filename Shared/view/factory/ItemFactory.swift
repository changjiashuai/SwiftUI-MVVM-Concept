//
//  ItemFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 13.05.2021.
//

import SwiftUI
import Ui


/// Set of templates for items View
/// ChartBuilder - contains builders for creating Chart elements
/// GridBuilder - contains builders for creating Grid elements
struct ItemFactory: ChartBuilder, GridBuilder {

    // MARK: - API Methods

    /// Create view template for defining User in the AgeChart
    /// - Parameter user: Set of data for User
    /// - Parameter selected: True - if selected
    /// - Returns: View defining how User age bar should be presented in the chart
    /// GridBuilder.bar - Create a bar for Chart
    @ViewBuilder
    func userAgeBar(_ user: User, _ selected: Bool, _ width: CGFloat) -> some View
    {
        let height = CGFloat(user.age)
        let label = "\(user.name) - \(user.age)"
        
        bar(label, width, height, selected)
    }

    /// Create view template for defining User in the UniversalList
    /// GridBuilder.row - Create View of a row
    /// - Parameter user: Set of data for User
    /// - Parameter selected: True - if selected
    /// - Returns: View defining how User row should be presented in the list
    @ViewBuilder
    func userRow(_ user: User, _ selected: Bool) -> some View
    {
        row("Name: \(user.name)", selected)
    }

    /// Create view template for defining Book in the UniversalList
    /// GridBuilder.row - Create View of a row
    /// - Parameter book: Set of data for Book
    /// - Parameter selected: True - if selected
    /// - Returns: View defining how Book row should be presented in the list
    @ViewBuilder
    func bookRow(_ book: Book, _ selected: Bool) -> some View
    {
        row(["Author: \(book.author)", "Title: \(book.title)"], selected)
    }
}
