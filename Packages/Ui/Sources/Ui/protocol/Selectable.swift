//
//  File.swift
//
//
//  Created by Igor Shelopaev on 21.05.2021.
//

import Foundation
import Data


/// Introduce selectable interfase for View
public protocol Selectable {

    associatedtype Item: Model

    /// Selected item
    var selectedItem: Item? { get set }
    
    /// Select item
    func select(_ item: Item)
    
}

extension Selectable{
    
    /// Check if item is selected
    /// - Parameter item: item to check
    /// - Returns: True is selected
    public func isSelected(_ item: Item) -> Bool{
        selectedItem?.id == item.id
    }
}
