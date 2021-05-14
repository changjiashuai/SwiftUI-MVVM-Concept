//
//  LocalFileRequest.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Defines specs of request from a file
public struct FileRequest: Request{
    
    /// Set of params to control what data to get from a remote source Range, Filter etc
    public var params: [String : String]?
    
    /// A path to the source file with data
    public var fileName: String
}
