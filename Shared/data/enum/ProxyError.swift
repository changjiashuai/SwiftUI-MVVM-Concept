//
//  ProxyError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Set of errors while fetching data from a remote source
enum ProxyError: DataError{
    case noFile(fileName: String)
    case loadError(fileName: String)

    func getDescription() -> String {
        var e: String

        switch self {
            case .noFile(let fileName): e = "file \(fileName) not found"
            case .loadError(let fileName): e = "could not load data from file \(fileName)"
        }

        return e
    }
}
