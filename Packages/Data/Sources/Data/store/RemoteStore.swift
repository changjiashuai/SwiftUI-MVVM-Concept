//
//  File.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


/// Store is a repo that maneges models conformed to Model protocol
public final class RemoteStore<T: Model, U: Proxy>: ObservableObject, Store  {
    
    /// Set of stored data
    @Published public private(set) var items: [T] = [T]()
    
    /// Contains error string if loading ends up with errors
    @Published public var error: String? = nil
    
    /// Informs the View that loading process is in the progress
    @Published public var loading: Bool = false
    
    /// Defines the communication level for data
    public var proxy: U
    
    // MARK: - Life circle
    
    /// Init
    /// - Parameter proxy: Performs requests to a remote source
    public init(proxy: U) {
        self.proxy = proxy
    }
    
    // MARK: - API Methods
    
    /// Get total of items in Store
    /// - Returns: count
    public func count() -> Int {
        items.count
    }
    
    /// Append a element of store
    /// - Parameter item: an element of store
    public func append(_ item: T) {
        items.append(item)
    }
    
    /// Append a group of elements of store
    /// - Parameter items: elements of store
    public func appendAll(_ items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    /// Remove all elements
    public func removeAll() {
        items.removeAll()
    }
    
    /// Get if Store is empty
    /// - Returns: true if empty
    public func isEmpty() -> Bool{
        items.count == 0
    }
   
    /// Load data from remote source
    /// - Parameters:
    ///   - params: Set of parameters to control a request of data (data range etc.)
    ///   - callback: Closure to perform something after loading
    public func load(params: [String: String]?, callback: @escaping () -> Void) {
       
        let queue = DispatchQueue.global(qos: .userInitiated)
        loading = true
        print("🟩 \(params ?? [:]))")
        //use something else if DispatchQueue is not an option for managing tasks on threads
        queue.asyncAfter(deadline: .now() + 1, execute: {
            let proxy = self.proxy
            let request = proxy.createRequest(params: params)
            let response = proxy.run(request)
            
            DispatchQueue.main.async {
                self.removeAll(); self.error = nil;
                self.appendAll(response.items as! [T])
                callback()
                self.loading = false
                if let error = response.error {
                    self.error = error.getDescription()
                }
            }
        })
    }
}
