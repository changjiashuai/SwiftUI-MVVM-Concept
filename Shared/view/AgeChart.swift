//
//  AgeChart.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import SwiftUI

/// List displays data conformed to Model protocol
struct AgeChart<T: Model, P: Proxy, Content: View>: View {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, P>
    
    /// Template to defined Item view
    let content: (T) -> Content
    
    /// View title
    let title: String?
    
    var autoLoad : Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                if title != nil {
                    Text("\(title!)")
                }
                Spacer()
                Button("update", action: load).opacity(store.loading ? 0 : 1)
                    .foregroundColor(.black)
                
            }.padding(.horizontal, 5)
            .frame(height: 50).background(Color.gray)
            HStack(alignment: .bottom, spacing: 0) {
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
            }.opacity(store.loading ? 0 : 1).offset(y: 50)
            .frame(height: 100, alignment: .bottomLeading)
        }.frame(width: 302, height: 150, alignment: .topLeading)
        .overlay(Text("Loading...")
        .opacity(store.loading ? 1 : 0), alignment: .center)
        .border(Color.white)
        .onAppear { if !store.loading && autoLoad { load() } }
    }
    
    
    /// load data
    func load() {
        store.load(params: ["page": "*"]) {
            print("do something after loading")
        }
    }
}
