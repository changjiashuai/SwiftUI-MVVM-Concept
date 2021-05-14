//
//  ReaderError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Set of errors while parsing  data
public enum ReaderError : DataError{
    
    /// Parsing error
    case readError    
    
    /// Get error description
    /// - Returns: Error text
    public func getDescription() -> String {
        var e: String

        switch self {
            case .readError: e = "could not parse data"
        }

        return e
    }
}
