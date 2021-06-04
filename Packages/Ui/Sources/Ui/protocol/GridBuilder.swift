//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Grid View
public protocol GridBuilder: Stylable, Supportable {
    
    //    Cell template
    associatedtype CellTemplate: View
    //    Row template
    associatedtype RowTemplate: View
    //  Content to display in a View element
    associatedtype Content
    
    /// Form view of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    func row(_ content: [Content], _ selected: Bool) -> RowTemplate
    
    /// Form view of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    func cell(_ content: Content, _ selected: Bool) -> CellTemplate
}

// MARK: - API Methods

public extension GridBuilder{
    
    /// Create View of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    func row(_ content: [String], _ selected: Bool) -> some View
    {
        HStack(spacing: 0) {
            ForEach(content, id: \.self) { text in
                cell(text, selected)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 33)
    }
    
    /// Form View of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    @ViewBuilder
    func row(_ content: String, _ selected: Bool) -> some View
    {
        row([content], selected)
    }
    
    /// Form View of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    @ViewBuilder
    func cell(_ content: String, _ selected: Bool) -> some View
    {
        Rectangle().overlay(
            Text(content).foregroundColor(.white)
                .font(isMac ? .system(size: 12, weight: .thin) : .body),
            alignment: .center
        )
        .foregroundColor(selected ? selectedRGB : cellRGB)
        .border(width: 1, edges: [.bottom], color: borderRGB)
    }
}


