//
//  File.swift
//
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Charts View
public protocol ChartBuilder: BlueStylable {

    associatedtype BarTemplate: View

    /// Create a bar for Chart
    /// - Parameters:
    ///   - label: Bar label
    ///   - width: Bar width
    ///   - height: Bar height
    /// - Returns: Bar View
    func bar(_ label: String, _ width: CGFloat, _ height: CGFloat, _ selected: Bool) -> BarTemplate
}

// MARK: - API Methods

public extension ChartBuilder {
    /// Create a bar for Chart
    /// - Parameters:
    ///   - label: Bar label
    ///   - width: Bar width
    ///   - height: Bar height
    /// - Returns: Bar View
    @ViewBuilder
    func bar(_ label: String, _ width: CGFloat, _ height: CGFloat, _ selected: Bool) -> some View
    {
        Rectangle()
            .frame(width: width, height: height)
            .overlay(
            Rectangle()
                .foregroundColor(selected ? selectedRGB : barRGB)
                .border(borderRGB)
                .overlay(
                Text(label).foregroundColor(.white).font(.system(size: 12, weight: .thin)),
                alignment: .center
            ),
            alignment: .topLeading
        )
            .padding(.horizontal, 8)

    }
}
