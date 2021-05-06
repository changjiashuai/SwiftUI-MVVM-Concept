//
//  RemoteStore.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import Foundation

/// Store is a repo that maneges models conformed to Model protocol
class RemoteStore<T: Model, U: Proxy>: Store, ObservableObject {
    
    /// Set of stored data
    @Published private(set) var items: [T] = [T]()
    
    /// Contains error string if loading ends up with errors
    @Published var error: String? = nil
    
    /// Informs the View that loading process is in the progress
    @Published var loading: Bool = false
    
    /// Defines the communication level for data
    var proxy: U
    
    /// Init
    /// - Parameter proxy: Performs requests to a remote source
    init(proxy: U) {
        self.proxy = proxy
    }
    
    /// Append a element of store
    /// - Parameter item: an element of store
    func append(_ item: T) {
        items.append(item)
    }
    
    /// Append a group of elements of store
    /// - Parameter items: elements of store
    func appendAll(_ items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    /// Remove all elements
    func removeAll() {
        items.removeAll()
    }
   
    /// Load data from remote source
    /// - Parameters:
    ///   - params: Set of parameters to control a request of data (data range etc.)
    ///   - callback: Closure to perform something after loading
    func load(params: [String: String]?, callback: @escaping () -> Void) {
       
        let queue = DispatchQueue.global(qos: .userInitiated)
        loading = true
        
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
