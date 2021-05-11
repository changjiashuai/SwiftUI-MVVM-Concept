//
//  CommandType.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation

/// Set of commands from Toolbar
/// Match between commands and requared methods defined in StoredView protocol
enum CommandType {
    case load, removeAll, idle
}
