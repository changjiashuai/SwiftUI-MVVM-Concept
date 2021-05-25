//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Charts View
public protocol ChartBuilder {
    
    associatedtype BarTemplate: View
    
    /// Create a bar for Chart
    /// - Parameters:
    ///   - label: Bar label
    ///   - width: Bar width
    ///   - height: Bar height
    /// - Returns: Bar View
    func bar(_ label: String,_ width: CGFloat,_ height: CGFloat,_ color: Color) -> BarTemplate
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
    func bar(_ label: String, _ width: CGFloat, _ height: CGFloat, _ color: Color) -> some View
    {
        Rectangle()
            .frame(width: width, height: height)
            .overlay(
                Rectangle().overlay(
                    Text(label).foregroundColor(.white).font(.system(.headline)),
                    alignment: .center
                ).foregroundColor(.clear),
                alignment: .topLeading
            )
            .padding(.horizontal, 8)
            .foregroundColor(color)
    }
}
