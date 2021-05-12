//
//  Command.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 11.05.2021.
//

import Foundation

/// Base protocol for defining commands from UI controls
protocol Command {
    
    /// time stamp for a command launch
    var date : Date { get }
}
