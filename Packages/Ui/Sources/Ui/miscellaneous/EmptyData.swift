//
//  Empty.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI

///Empty data view
public struct EmptyData: View, Stylable {

    /// The type of view representing the body of this view
    public var body: some View {
        Color.clear.overlay(
            Text("Empty").foregroundColor(.white).font(.system(size: 14, weight: .thin)), alignment: .center)
            .padding(.top, 35)
            .background(backgroundRGB)
        
    }

    // MARK: - Life circle

    /// Initializer
    public init() { }
}
