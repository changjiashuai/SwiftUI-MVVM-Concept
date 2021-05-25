//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Grid View
protocol GridBuilder {
    
//    Cell template
    associatedtype CellTemplate: View
//    Row template
    associatedtype RowTemplate: View
//  Content to display in a View element
    associatedtype Content
    
    /// Form view of a row
    /// - Parameter content: Text to display
    /// - Returns: Row view
    func row(_ content: [Content]) -> RowTemplate
    
    /// Form view of a cell
    /// - Parameter content: Text to display
    /// - Returns: Cell view
    func cell(_ content: Content) -> CellTemplate
}

