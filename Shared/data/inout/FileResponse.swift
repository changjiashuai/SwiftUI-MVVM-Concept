//
//  LocalFileResponse.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Contains result of fetched data
struct FileResponse<T: Model>: Response{   
    
    /// Defines specs of request
    let request : Request    
    
    /// Fetched data
    let items: [T]
    
    /// Error while parsing or fetching from a file
    let error : Error?
}
