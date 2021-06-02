//
//  Loading.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI


/// Mask modifier
fileprivate struct Mask: ViewModifier, Stylable {
    
    /// true - is loading, false - loaded
    let loading : Bool
    
    /// Text while loading
    let text : String
    
    /// Width
    var width : CGFloat { loading ? 1.0 : 0.0 }
    
    /// Visibility
    var vision : Double { loading ? 1.0 : 0.0 }
    
    // MARK: - API Methods

    /// The type of view representing the body of this view
    func body(content: Content) -> some View {
        content.overlay(
            Rectangle()
                .foregroundColor(componentRGB)
                .overlay(
                    Text(text).foregroundColor(.white).font(.system(.body)),
                    alignment: .center)
                .opacity(vision),
            alignment: .center)
            .border(width: width, edges: [.leading, .bottom], color: selectedRGB)
            .border(width: width, edges: [.top, .trailing], color: borderRGB)
            .background(componentRGB)
    }
}

// MARK: -- Extension --

extension View {
    
    /// Mask or unmask View. Depends on Store loading process
    /// - Parameters:
    ///   - loading: Boolean flag  true - is loading, false - loaded
    ///   - text: Text displayed while loading. Default value "Loading..."
    /// - Returns: Mask view
    public func mask(_ loading: Bool, text: String = "Loading...") -> some View {
        self.modifier(Mask(loading: loading, text: text))
    }
}
