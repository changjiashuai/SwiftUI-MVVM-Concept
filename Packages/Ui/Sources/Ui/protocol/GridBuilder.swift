//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Grid View
public protocol GridBuilder {
    
    //    Cell template
    associatedtype CellTemplate: View
    //    Row template
    associatedtype RowTemplate: View
    //  Content to display in a View element
    associatedtype Content
    
    /// Form view of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    func row(_ content: [Content], _ color: Color) -> RowTemplate
    
    /// Form view of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    func cell(_ content: Content) -> CellTemplate
}

// MARK: - API Methods

public extension GridBuilder{
    
    /// Create View of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    func row(_ content: [String], _ color: Color) -> some View
    {
        HStack {
            ForEach(content, id: \.self) { text in
                cell(text)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 25)
        .foregroundColor(color)
    }
    
    /// Form View of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    func row(_ content: String, _ color: Color) -> some View
    {
        row([content], color)
    }
    
    /// Form View of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    @ViewBuilder
    func cell(_ content: String) -> some View
    {
        Rectangle().overlay(
            Text(content).foregroundColor(.white).font(.system(.headline)),
            alignment: .center
        )
    }
}

