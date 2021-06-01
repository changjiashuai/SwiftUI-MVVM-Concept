//
//  SwiftUIView.swift
//
//
//  Created by Igor Shelopaev on 25.05.2021.
//

import SwiftUI


/// Add color style scheem behaviour
public protocol Stylable {


}

public extension Stylable {
    var backgroundRGB: LinearGradient {
        LinearGradient(gradient:
                Gradient(
                stops: [
                    Gradient.Stop(
                        color:
                            Color(red: 0.23, green: 0.27, blue: 0.43, opacity: 1),
                        location: 0.0),
                    Gradient.Stop(color:
                            Color(red: 0.2, green: 0.24, blue: 0.4, opacity: 1),
                        location: 1.0)]),
            startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
    }

    var barRGB: Color {
        Color(red: 0.22, green: 0.26, blue: 0.48, opacity: 1)
    }

    var selectedRGB: Color {
        Color(red: 0.32, green: 0.36, blue: 0.52, opacity: 1)
    }

    var borderRGB: Color {
        Color(red: 0.26, green: 0.31, blue: 0.51, opacity: 1)
    }

    var componentBorderRGB: Color {
        Color(red: 0.2, green: 0.24, blue: 0.4, opacity: 1)
    }

    var componentRGB: Color {
        Color(red: 0.16, green: 0.19, blue: 0.36, opacity: 1)
    }

    var cellRGB: Color {
        Color(red: 0.15, green: 0.18, blue: 0.34, opacity: 1)
    }

    var barAnimationRGB: LinearGradient {
        LinearGradient(gradient: Gradient(
            colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1),
                Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1)]
        ), startPoint: .top, endPoint: .bottom)
    }
    #if os(iOS)
    var uiBackgroundColor: UIColor {
        UIColor(red: 0.2, green: 0.23, blue: 0.4, alpha: 1.0)
    }
    #endif
}
