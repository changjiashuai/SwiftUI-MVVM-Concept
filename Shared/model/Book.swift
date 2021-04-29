//
//  Book.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import Foundation

/// Model defining Book
struct Book: Model {
    let id: Int
    
    /// title of a book
    let title: String    
    
    /// author of a book
    let author: String
}
