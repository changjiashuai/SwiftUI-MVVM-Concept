//
//  Json.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation

/// Parse JSON data loaded from a remote source
struct Json<T: Model>: Reader{       
    
    /// Parse JSON data
    /// - Parameter data: JSON data
    /// - Throws: Throws an error if there's error while parsing
    /// - Returns: Set of data
    func read(data : Data)  throws -> [T]{
        if let items = try? JSONDecoder().decode([T].self, from: data) {
            return items
        } else {
            throw ReaderError.ReadError
        }
    }
}
