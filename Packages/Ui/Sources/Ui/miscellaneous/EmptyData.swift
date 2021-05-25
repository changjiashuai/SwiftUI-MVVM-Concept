//
//  Empty.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI

///Empty data view
public struct EmptyData: View {
    
    /// The type of view representing the body of this view
    public var body: some View {
        Color.clear.overlay(Text("Empty"),alignment: .center)
            .padding(.top, 35)
    }
    
    // MARK: - Life circle
    
    /// Initializer
    public init(){ }
}
