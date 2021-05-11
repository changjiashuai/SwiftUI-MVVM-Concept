//
//  UniversalList.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import SwiftUI


/// List displays data conformed to Model protocol
struct UniversalList<T: Model, U: Proxy, V: View, Content: View>: View {
    
    /// A view builder that creates the content of an Item view
    let content: (T) -> Content
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// ToolBar with set of controls
    let toolBar: V
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack(alignment: .top) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            getListBody()
        }.frame(height: 150, alignment: .topLeading)
        .mask(!notLoading)
        .border(Color.white)
        .onAppear { if notLoading { load() } }
    }
    
    /// - Returns: list
    @ViewBuilder
    private func getListBody() -> some View {
        VStack(spacing: 5) {
            if store.error != nil { ErrorView(store.error!)}
            else {
                if store.items.count > 0 {
                    ForEach(store.items, id: \.self) { item in
                        content(item)
                    }
                } else { EmptyData() }
            }
        }
        .offset(y: 50)
        .frame(height: 100, alignment: .topLeading)
    }

    /// Act on a command from the ToolBar
    /// - Parameter state: Command from toolBar to do something
    func onCommandChanged(_ command: StoreCommand) {
        switch command.type {
        case .removeAll: removeAll()
        case .load: load()
        case .idle: return
        }
    }
    
    /// clear data
    func removeAll(){
        store.removeAll()
    }
    
    /// load data
    func load() {
        store.load(params: ["page" : "*"]) {
            print("do something after loading")
        }
    }
}
