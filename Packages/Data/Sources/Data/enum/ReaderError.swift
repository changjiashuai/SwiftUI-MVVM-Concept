//
//  ReaderError.swift
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Set of errors while parsing  data
public enum ReaderError : DataError{
    
    /// Parsing error
    case readError    
    
    
    // MARK: - API Methods
    
    /// Get error description
    /// - Returns: Error text
    public func getDescription() -> String {
        switch self {
            case .readError: return "could not parse data"
        }
    }
}
