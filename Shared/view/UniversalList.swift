//
//  UniversalList.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import SwiftUI


/// List displays data conformed to Model protocol
struct UniversalList<T: Model, P: Proxy, Content: View>: View {
    
    /// A view builder that creates the content of an Item view
    let content: (T) -> Content
    
    /// Store with data
    @StateObject var store: RemoteStore<T, P>
    
    /// View title
    let title : String?    
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack {
            getToolBar()
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
            if store.error != nil { Text("\(store.error!)").foregroundColor(.red) }
            else {
                if store.items.count > 0 {
                    ForEach(store.items, id: \.self) { item in
                        content(item)
                    }
                } else {
                    Text("Empty")
                }
            }
        }
        .opacity(store.loading ? 0 : 1).offset(y: 50)
    }
    
    /// - Returns: tool bar
    @ViewBuilder
    private func getToolBar() -> some View {
        HStack {
            if title != nil {
                Text("\(title!)")
            }
            Spacer()
            Button("update", action: load).opacity(store.loading ? 0 : 1)
                .foregroundColor(.black)
        }.padding(.horizontal, 5)
        .frame(height: 50).background(Color.gray)
    }
    
    /// load data
    func load() {
        store.load(params: ["page" : "*"]) {
            print("do something after loading")
        }
    }
}
