//
//  StoredView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 12.05.2021.
//

import Foundation


/// Add controllable behavior to view to obey commands from others views
protocol Controllable{
    func onCommandChanged(_ command: StoreCommand)
}

