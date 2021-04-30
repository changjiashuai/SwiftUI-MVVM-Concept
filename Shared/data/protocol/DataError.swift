//
//  DataError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import Foundation

protocol DataError: Error {
    func getDescription() -> String
}
