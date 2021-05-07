//
//  UniversalList.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import SwiftUI


/// List displays data conformed to Model protocol
struct UniversalList<T: Model, U: Proxy, V: AbstractToolBar, Content: View>: View, StoredView {
    
    /// A view builder that creates the content of an Item view
    let content: (T) -> Content
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// ToolBar with diff controls
    let toolBar: V
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack(alignment: .top) {
            toolBar.onPreferenceChange(StateKey.self, perform: self.onStateChanged)
            getListBody()
        }.frame(height: 150, alignment: .topLeading)
        .mask(store.loading)
        .border(Color.white)
        .onAppear { if notLoading { load() } }
    }
    
    /// - Returns: list
    @ViewBuilder
    private func getListBody() -> some View {
        VStack {
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

    /// clear data
    func clear(){
        store.removeAll()
    }
    
    /// load data
    func load() {
        store.load(params: ["page" : "*"]) {
            print("do something after loading")
        }
    }
}
