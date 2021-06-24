//
//  File.swift
//
//  Created by Igor Shelopaev on 14.05.2021.
//

import Foundation


/// Store is a repo that maneges models conformed to Model protocol
public final class RemoteStore<T: Model, U: Proxy>: Store where T == U.Item {
    
    /// Set of stored data
    @Published public private(set) var items = [T]()
    
    /// Contains error string if loading ends up with errors
    @Published public var error: String? = nil
    
    /// Informs the View that loading process is in the progress
    @Published public private(set) var loading: Bool = false
    
    /// Total amount of items in Store
    @Published public private(set) var total: Int = 0
    
    
    /// Currently performed task
    var currentWork : DispatchWorkItem?
    
    /// Defines the communication level for data
    public var proxy: U
    
    // MARK: - Life circle
    
    /// Init
    /// - Parameter proxy: Performs requests to a remote source
    public init(proxy: U) {
        self.proxy = proxy
    }
    
    deinit {
        if let c = currentWork?.isCancelled, c == false {
            stopTask()
        }
    }
    
    // MARK: - Private Methods
    
    /// Stop curent task
    private func stopTask(){
        currentWork?.cancel()
        currentWork = nil
    }
    
    /// Set total
    private func setTotal() {
        total = count()
    }
    
    /// Set of cations before loading
    private func beforeLoad() {
        loading = true; error = nil
    }
    
    /// Set of cations after loading
    private func afterLoad() {
        setTotal()
        loading = false
        stopTask()
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
        error = nil
    }
    
    /// Get if Store is empty
    /// - Returns: true if empty
    public func isEmpty() -> Bool {
        items.count == 0
    }
    
    /// Load data from remote source
    /// - Parameters:
    ///   - params: Set of parameters to control a request of data (data range etc.)
    ///   - callback: Closure to perform something after loading
    /// CallbackClosure -  Optinal closure type for a collback () -> Void
    /// Params - Dic for a request params [String: String]
    public func load(params: Params? = nil) {
        
        beforeLoad()
        
        if let c = currentWork?.isCancelled, c == false {
            stopTask()
        }
        
        currentWork = DispatchWorkItem { [weak self] in
            if let proxy = self?.proxy {
                let request = proxy.createRequest(params: params)
                let response = proxy.run(request)
                
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.removeAll()
                    if let elms = response.items as? [T]{
                        self.appendAll(elms)
                    }
                    if let error = response.error {
                        self.error = error.getDescription()
                    }
                    
                    self.afterLoad()
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated)
            .asyncAfter(deadline: .now() + 0.5, execute: currentWork!)
    }

}
