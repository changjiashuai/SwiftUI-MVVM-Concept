//
//  Loadable.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation

/// Protocol for a view containing a store
public protocol Loadable {
    associatedtype AbstractStore: Store
    /// Repository with data
    var store: AbstractStore { get }
}

extension Loadable{
    /// Indicates state of loading
    public var notLoading: Bool {
        !store.loading
    }
}
