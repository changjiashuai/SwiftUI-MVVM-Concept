//
//  LocalFile.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation

/// Defines communication layer to get data from local files
struct File<T:Model, R: Reader>: Proxy {
    
    /// Parse data loaded from a file
    var reader: R
    
    /// File path
    let fileName: String
    
    /// Create request
    /// - Parameter params: set of params to control what data to get from a remote source Range, Filter etc
    /// - Returns: specs of request
    func createRequest(params: [String: String]?) -> FileRequest {
        FileRequest(params: params, fileName: fileName)
    }
    
    /// Create response
    /// - Parameters:
    ///   - request: Initial request
    ///   - error: Errors desc for View
    ///   - items: Store items
    func createResponse(_ request: FileRequest, _ error: DataError?, _ items: [T] = []) -> FileResponse<T> {
        FileResponse(request: request, items: items, error: error)
    }
    
    /// Fetch data from a file
    func run(_ request: FileRequest) -> FileResponse<T>  {
        let data: Data
        let fn = request.fileName
        var items: [T] = []
        
        guard let file = Bundle.main.url(forResource: request.fileName, withExtension: nil) else {
            return createResponse(request, ProxyError.noFile(fileName: fn))
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            return createResponse(request, ProxyError.loadError(fileName: fn))
        }
        
        do {
            items = try reader.read(data: data) as! [T]
        } catch {
           return createResponse(request, ReaderError.readError)
        }


        return createResponse(request, nil, items)
    }
}
