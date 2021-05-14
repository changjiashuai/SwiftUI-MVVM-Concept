//
//  Book.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation
import Data

/// Model defining Book
struct Book: Model {
    let id: Int
    
    /// Title of a book
    let title: String    
    
    /// Author of a book
    let author: String
}
