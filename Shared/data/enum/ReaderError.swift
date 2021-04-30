//
//  ReaderError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Set of errors while parsing  data
enum ReaderError : DataError{
    case readError
    
    func getDescription() -> String {
        var e: String

        switch self {
            case .readError: e = "could not parse data"
        }

        return e
    }
}
