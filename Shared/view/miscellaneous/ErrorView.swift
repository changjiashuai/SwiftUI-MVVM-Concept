//
//  ErrorView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI


/// View for displaying errors
struct ErrorView: View {
    
    /// Error description
    let text : String
    
    
    /// Initializer
    /// - Parameter text: Error text
    init(_ text : String){
        self.text = text
    }
    
    /// The type of view representing the body of this view
    var body: some View {
        Color.clear.overlay(Text("\(text)").foregroundColor(.red), alignment: .center)
    }
}


