//
//  Supportable.swift
//  
//
//  Created by Igor Shelopaev on 04.06.2021.
//

import SwiftUI


/// Support to define different environment and specs
public protocol Supportable{
    
}

public extension Supportable{
    ///Support to define  mac platform
    var isMac: Bool {
        var isMac: Bool = false
        #if os(macOS)
            isMac = true
        #endif
        return isMac
    }
    
    ///Support to define an iPhone devoce
    #if os(iOS)
    var isPhone: Bool {
            return UIDevice.current.userInterfaceIdiom == .phone
        }
    #endif
}
