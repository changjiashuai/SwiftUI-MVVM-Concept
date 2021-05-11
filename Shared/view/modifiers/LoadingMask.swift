//
//  Loading.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI

fileprivate struct Mask: ViewModifier {
    
    /// true - is loading, false - loaded
    let loading : Bool
    
    /// text while loading
    let text : String
    
    func body(content: Content) -> some View {
        content.overlay(Rectangle().foregroundColor(.gray)
                            .overlay(Text(text).foregroundColor(.black), alignment: .center)
                            .opacity(loading ? 1 : 0), alignment: .center)
    }
}

extension View {
    func mask(_ loading: Bool, text: String = "Loading...") -> some View {
        self.modifier(Mask(loading: loading, text: text))
    }
}
