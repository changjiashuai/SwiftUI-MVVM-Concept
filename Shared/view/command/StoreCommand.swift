//
//  StoreCommand.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation


/// Defines command for store from a UI control
struct StoreCommand: Command {
    let type : CommandType
    let date = Date()
}

/// Base protocol for defining commands from UI controls
protocol Command: Equatable {

}
