//
//  LocalFileResponse.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Contains result of fetched data
public struct FileResponse<T: Model>: Response{
    
    /// Defines specs of request
    public let request : Request
    
    /// Fetched data
    public let items: [T]
    
    /// Error while parsing or fetching from a file
    public let error : DataError?
}
