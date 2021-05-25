//
//  File.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI

/// Set of elementary blocks for creating Charts View
protocol ChartBuilder {
    
    associatedtype BarTemplate: View
    
    /// Get a bar for Chart
    /// - Parameters:
    ///   - label: Bar label
    ///   - width: Bar width
    ///   - height: Bar height
    /// - Returns: Bar View
    func bar(_ label: String, width: CGFloat, height: CGFloat) -> BarTemplate
}
