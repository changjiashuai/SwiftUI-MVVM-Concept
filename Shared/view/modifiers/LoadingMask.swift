//
//  Loading.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI

fileprivate struct Mask: ViewModifier {
    
    let loading : Bool
    
    func body(content: Content) -> some View {
        content.overlay(Text("Loading...").opacity(loading ? 1 : 0), alignment: .center)
    }
}

extension View {
    func mask(_ loading: Bool) -> some View {
        self.modifier(Mask(loading: loading))
    }
}
