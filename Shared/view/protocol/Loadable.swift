//
//  Loadable.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation
import Data

/// Protocol for a view containing a store
protocol Loadable {
    associatedtype AbstractStore: Store
    /// Repository with data
    var store: AbstractStore { get }
}

extension Loadable{
    /// Indicates state of loading
    var notLoading: Bool {
        !store.loading
    }
}
