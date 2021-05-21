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
