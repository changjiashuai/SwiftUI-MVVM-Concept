//
//  Model.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation

/// Protocol for models
protocol Model: Identifiable, Hashable, Codable {
    
    /// Identifier of Model
    var id: Int { get }
}
