//
//  StoredView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import Foundation


/// Set of methods for views with store
protocol StoredView {
           
    /// load data
    func load()
    
    /// clear data
    func clear()
}

extension StoredView{
    
    /// Act on a command from the ToolBar
    /// - Parameter command: Command from toolBar to do something
    func onStateChanged(_ command: ToolBarState) {
        switch command {
        case .CLEAR: clear()
        case .LOAD: load()
        case .IDLE: return
        }
    }
}
