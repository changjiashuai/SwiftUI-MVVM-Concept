//
//  Reader.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation


/// Processes data fetched from a remote source
protocol Reader {
    
    /// Defines an element of Store
    associatedtype Item : Model
    
    /// Parses data loaded from remote source
    /// - Parameter data: set of data
    func read(data : Data) throws -> [Item]
}
