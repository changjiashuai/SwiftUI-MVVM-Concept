//
//  StoreCommandKey.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 17.05.2021.
//

import SwiftUI

/// A named value produced by a view.
struct StoreCommandKey: PreferenceKey {
    
    /// The default value of the preference.
    static var defaultValue = StoreCommand()
    
    /// Combines a sequence of values by modifying the previously-accumulated value with the result of a closure that provides the next value.
    static func reduce(value: inout StoreCommand, nextValue: () -> StoreCommand) {
        value = nextValue()
    }
}
