//
//  HandlerError.swift
//  
//
//  Created by Igor Shelopaev on 28.05.2021.
//

import Foundation

// Set of errors if the right to execute a command is broken
public enum HandlerError {

    case notAuthenticated
    case notAuthorized

    public var description: String {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated"
        case .notAuthorized:
            return "User is not authorized"
        }
    }
}
