//
//  LocalFile.swift
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation

/// Defines communication layer to get data from local files
public struct File<T:Model, R: Reader>: Proxy {
    
    /// Parse data loaded from a file
    public let reader: R
    
    /// File path
    private let fileName: String
    
    // MARK: - Life circle
    
    public init(reader: R, fileName: String){
        self.reader = reader
        self.fileName = fileName
    }
    
    // MARK: - API Methods
    
    /// Create request
    /// - Parameter params: set of params to control what data to get from a remote source Range, Filter etc
    /// - Returns: specs of request
    /// Params - Dic for a request params
    public func createRequest(params: Params?) -> FileRequest {
        FileRequest(params: params, fileName: fileName)
    }
    
    /// Create response
    /// - Parameters:
    ///   - request: Initial request
    ///   - error: Errors desc for View
    ///   - items: Store items
    public func createResponse(_ request: FileRequest, _ error: DataError?, _ items: [T] = []) -> FileResponse<T> {
        FileResponse(request: request, items: items, error: error)
    }
    
    /// Fetch data from a file
    public func run(_ request: FileRequest) -> FileResponse<T>  {
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
