//
//  ProxyError.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation


/// Set of errors while fetching data from a remote source
enum ProxyError : Error{
    case NoFile(fileName : String)
    case LoadError(fileName : String)
}
