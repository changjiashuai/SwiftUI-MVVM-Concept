//
//  AutoStack.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 26.05.2021.
//

import SwiftUI

#if os(iOS)
/// Adaptive stack
@available(iOS 14.0, *)
public struct AutoStack<Content: View>: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    /// The content of View
    let content: Content

    /// Whether this stack should switch to compact mode
    var isCompact: Bool {
        horizontalSizeClass == .compact
    }

    public var body: some View {
        if isCompact {
            VStack(spacing: 0) { content }
                .padding(.bottom, 25)
        } else {
            HStack(spacing: 0) { content }
                .padding(.horizontal, 35)
                .padding(.bottom, 15)
            
        }
    }
    
    // MARK: - Life circle
    
    /// Initializer
    /// - Parameters:
    ///   - content: View to put into the adaptive Stack
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}
#endif
