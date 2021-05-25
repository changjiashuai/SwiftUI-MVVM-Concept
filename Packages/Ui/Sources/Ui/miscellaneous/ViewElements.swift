//
//  File.swift
//
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI


/// Set of elementary blocks for creating View
public struct ElementBuilder {

    // MARK: - Life circle

    public init() { }

    // MARK: - API Methods

    /// Form view of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    public func row(_ content: [String]) -> some View {
        HStack {
            ForEach(content, id: \.self) { text in
                cell(text)
            }
        }
            .frame(maxWidth: .infinity)
            .frame(height: 25)
    }

    /// Form view of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    public func row(_ content: String) -> some View {
        row([content])
    }

    /// Form view of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    @ViewBuilder
    public func cell(_ content: String) -> some View
    {
        Rectangle().overlay(
            Text(content).foregroundColor(.white).font(.system(.headline)),
            alignment: .center
        )
    }

    /// Get a bar for Chart
    /// - Parameters:
    ///   - label: Bar label
    ///   - width: Bar width
    ///   - height: Bar height
    /// - Returns: Bar View
    @ViewBuilder
    public func bar(_ label: String, width: CGFloat, height: CGFloat) -> some View {
        Rectangle().frame(width: width, height: height)
            .overlay(
            cell(label).foregroundColor(.clear),
            alignment: .topLeading
        )
            .padding(.horizontal, 8)
    }
}
