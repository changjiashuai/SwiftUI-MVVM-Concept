//
//  Logger.swift
//  
//
//  Created by Igor Shelopaev on 30.05.2021.
//

import Foundation
import Data

/// Log actions
public class Logger: LoggerApi{
    
    // MARK: - Life circle
    
    public init() { }
 
    /// Log command properties
    /// Return .logIsFaild if you expand the method and handle error cases
    /// - Parameter command: command from View
    /// - Returns: Optional Error
    public func handle<T>(_ command: T) -> HandlerError? where T: Command {

        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "UTC")
        format.dateFormat = "yy-mm-dd HH:mm"
                
        let date = command.date
        let text = format.string(from: date)
        
        if let params = command.params{
            print("\(text) 🟩 \(params)")
        }
        
      return nil
    }
    
}
