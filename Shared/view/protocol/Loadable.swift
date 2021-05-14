//
//  Loadable.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


/// Protocol for a view containing a store
protocol Loadable {
    associatedtype AbstractStore: Store
    /// Repository with data
    var store: AbstractStore { get }    
}

extension Loadable{
    /// Check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
}
