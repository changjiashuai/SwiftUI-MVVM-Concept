//
//  Loading.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI


/// Mask modifier
fileprivate struct Mask: ViewModifier {
    
    /// true - is loading, false - loaded
    let loading : Bool
    
    /// Text while loading
    let text : String
    
    // MARK: - API Methods
    
    /// The type of view representing the body of this view
    func body(content: Content) -> some View {
        content.overlay(Rectangle().foregroundColor(.gray)
                            .overlay(Text(text).foregroundColor(.black), alignment: .center)
                            .opacity(loading ? 1 : 0), alignment: .center)
    }
}


extension View {
    
    /// Mask or unmask View. Depends on Store loading process
    /// - Parameters:
    ///   - loading: Boolean flag  true - is loading, false - loaded
    ///   - text: Text displayed while loading. Default value "Loading..."
    /// - Returns: Mask view
    func mask(_ loading: Bool, text: String = "Loading...") -> some View {
        self.modifier(Mask(loading: loading, text: text))
    }
}
