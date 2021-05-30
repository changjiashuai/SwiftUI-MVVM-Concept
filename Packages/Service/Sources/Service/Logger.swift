//
//  Logger.swift
//  
//
//  Created by Igor Shelopaev on 30.05.2021.
//

import Foundation
import Data


/// Log actions
public class Logger: ObservableObject, Handler{
    
    // MARK: - Life circle
    
    public init() { }
    
    // MARK: - API Methods
    
    /// Log command properties
    /// Return .logIsFaild if you expand the method and handle error cases
    /// - Parameter command: command from View
    /// - Returns: Optional Error
    public func handle(_ command : StoreCommand) -> HandlerError? {

        if let params = command.params{
            print("Log params: 🟩 \(params)")
        }
        
      return nil
    }   
    
}
