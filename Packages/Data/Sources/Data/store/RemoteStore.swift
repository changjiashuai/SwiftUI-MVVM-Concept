//
//  File.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


/// Store is a repo that maneges models conformed to Model protocol
public final class RemoteStore<T: Model, U: Proxy>: ObservableObject, Store {
    
    /// Set of stored data
    @Published public private(set) var items = [T]()
    
    /// Contains error string if loading ends up with errors
    @Published public var error: String? = nil
    
    /// Informs the View that loading process is in the progress
    @Published public var loading: Bool = false
    
    /// Total amount of items in Store
    @Published public var total: Int = 0
    
    /// Defines the communication level for data
    public var proxy: U
    
    // MARK: - Life circle
    
    /// Init
    /// - Parameter proxy: Performs requests to a remote source
    public init(proxy: U) {
        self.proxy = proxy
    }
    
    // MARK: - Private Methods
    
    /// Set total
    private func setTotal(){
        total = count()
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
        self.setTotal()
    }
    
    /// Get if Store is empty
    /// - Returns: true if empty
    public func isEmpty() -> Bool {
        items.count == 0
    }
    
    /// Set of cations before loading
    ///   - params: Set of parameters to control a request of data (data range etc.)
    private func beforeLoad(_ params: Params?) {
        loading = true; error = nil
    }
    
    /// Load data from remote source
    /// - Parameters:
    ///   - params: Set of parameters to control a request of data (data range etc.)
    ///   - callback: Closure to perform something after loading
    /// CallbackClosure -  Optinal closure type for a collback () -> Void
    /// Params - Dic for a request params [String: String]
    public func load(params: Params?) {
        
        beforeLoad(params)
        
        DispatchQueue.global(qos: .userInitiated)
            .asyncAfter(
                deadline: .now() + 1,
                execute: {
                    let request  = self.proxy.createRequest(params: params)
                    let response = self.proxy.run(request)
                    
                    DispatchQueue.main.async {
                        self.removeAll()
                        self.appendAll(response.items as! [T])
                        self.setTotal()
                        self.loading = false
                        if let error = response.error {
                            self.error = error.getDescription()
                        }
                    }
                }) // end of asyncAfter
    }
}
