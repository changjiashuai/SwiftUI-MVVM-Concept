//
//  File.swift
//
//
//  Created by Igor Shelopaev on 21.05.2021.
//

import Foundation
import Data

public protocol Selectable {

    associatedtype Item: Model

    /// Selected item
    var selectedItem: Item? { get }

}
