//
//  ToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI


/// Set of commands from Toolbar
/// Match between commands and requared methods defined in StoredView protocol
enum ToolBarState {
    case LOAD, CLEAR, IDLE
}


/// Toolbar for any View supporting StoredView protocol
struct ToolBar: AbstractToolBar {
    
    /// Title text
    let title : String?
    
    /// State of toolbar
    @State var curentState = ToolBarState.IDLE
    
    var body: some View {
        HStack {
            if title != nil {
                Text("\(title!)")
            }
            Spacer()
            Button("update", action: {                
                curentState = .LOAD
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    curentState = .IDLE
                }
            })
            Button("clear", action: {
                curentState = .CLEAR
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    curentState = .IDLE
                }
            })
        }
        .foregroundColor(.black)
        .padding(.horizontal, 5)
        .frame(height: 50).background(Color.gray)
        .preference(key: StateKey.self, value: curentState)
    }
}

struct StateKey: PreferenceKey {
    static let defaultValue: ToolBarState = ToolBarState.IDLE
    static func reduce(value: inout ToolBarState, nextValue: () -> ToolBarState) {
        value = nextValue()
    }
}

