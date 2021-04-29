//
//  LocalFile.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 28.04.2021.
//

import Foundation

/// Defines communication layer to get data from local files
struct File<T:Model, R: Reader>: Proxy {
    typealias Item = T
    typealias LocalFileReader = R

    /// Parse data loaded from a file
    var reader: LocalFileReader

    
    /// File path
    let fileName: String

    
    /// Create request
    /// - Parameter params: set of params to control what data to get from a remote source Range, Filter etc
    /// - Returns: specs of request
    func createRequest(params: [String: String]?) -> FileRequest {
        FileRequest(params: params, fileName: fileName)
    }
    
    /// Fetch data from a file
    func run(_ request: FileRequest) -> FileResponse<Item> {
        let data: Data
        let fn = request.fileName
        var items: [Item] = []
        
        guard let file = Bundle.main.url(forResource: request.fileName, withExtension: nil) else {
            return FileResponse(request: request, items:items, error: ProxyError.NoFile(fileName: fn))
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            return FileResponse(request: request, items: [], error: ProxyError.LoadError(fileName: fn))
        }
        
        do {
            items = try reader.read(data: data) as! [Item]
        } catch {
           return FileResponse(request: request, items: items, error: ReaderError.ReadError)
        }


        return FileResponse(request: request, items: items, error: nil)
    }
}
