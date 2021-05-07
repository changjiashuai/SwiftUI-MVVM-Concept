//
//  Empty.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI

///Empty data view
struct EmptyData: View {
    var body: some View {
        Color.clear.overlay(Text("Empty"),alignment: .center)
    }
}
