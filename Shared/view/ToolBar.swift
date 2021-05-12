//
//  ToolBar.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 07.05.2021.
//

import SwiftUI



/// Toolbar for any View supporting StoredView protocol
struct ToolBar<Content: View> : View{

    /// State of toolbar
    @State var curentCommand: StoreCommand = StoreCommand()
    
    /// Title text
    let title: String?
    
    /// Set of extra controls to add to default set
    let items : (() -> Content)?

    
    /// Initializer
    /// - Parameters:
    ///   - title: Text of title
    ///   - items: Additional items
    init(_ title: String? = nil ,_ items:( () -> Content )? = nil ) {
        self.title = title
        self.items = items
    }

    /// The type of view representing the body of this view.
    var body: some View {
        HStack {
            if title != nil {
                Text("\(title!)").frame(minWidth: 50)
            }
            Spacer()
            getItemsView()
            Button("update", action: {
                curentCommand = LoadCommand(params:["page":"*"], callback: {print("do something")})
            })
            Button("clear", action: {
                curentCommand = RemoveAllCommand()
            })
        }
            .foregroundColor(.black)
            .padding(.horizontal, 5)
            .frame(height: 50).background(Color.gray)
            .preference(key: StoreCommandKey.self, value: curentCommand)
    }
    
    /// Get View for extra controls
    /// - Returns: get extra controls from config
    @ViewBuilder
    func getItemsView() -> some View{
        if items != nil{
            HStack{ items!() }.padding().background(Color.secondary)
        }else{
            EmptyView()
        }
    }
}

struct StoreCommandKey: PreferenceKey {

    static var defaultValue = StoreCommand()

    static func reduce(value: inout StoreCommand, nextValue: () -> StoreCommand) {
        value = nextValue()
    }
}
