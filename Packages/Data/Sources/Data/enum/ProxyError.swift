//
//  ProxyError.swift
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Set of errors while fetching data from a remote source
public enum ProxyError: DataError{
    
    /// File not found
    case noFile(fileName: String)
    /// Error while fetching data from a source
    case loadError(fileName: String)

    /// Get error description
    /// - Returns: Error text
    public func getDescription() -> String {
        switch self {
            case .noFile(let fileName): return "file \(fileName) not found"
            case .loadError(let fileName): return "could not load data from file \(fileName)"
        }
    }
}
