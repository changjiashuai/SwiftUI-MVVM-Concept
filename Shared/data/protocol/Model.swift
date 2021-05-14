//
//  Model.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation

/// Protocol for models
protocol Model: Identifiable, Hashable, Codable {
    
    /// Model ID
    var id: Int { get }
}
