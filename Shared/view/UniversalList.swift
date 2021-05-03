//
//  UniversalList.swift
//
//  Created by Igor Shelopaev on 27.04.2021.
//

import SwiftUI


/// List displays data conformed to Model protocol
struct UniversalList<T: Model, P: Proxy, Content: View>: View {
   
    /// Store with data
    @StateObject var store: RemoteStore<T, P>

    /// Template to defined Item view
    let content: (T) -> Content

    
    /// View title
    let title : String?
    
    var body: some View {
        ZStack {
            HStack {
                if title != nil{
                    Text("\(title!)")
                }
                Spacer()
                Button("update", action: load).opacity(store.loading ? 0 : 1)
                    .foregroundColor(.black)
                
            }
                .padding(5).frame(height: 50).background(Color.gray)
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
        }.frame(width: 302, height: 150, alignment: .topLeading)
            .overlay(Text("Loading...").opacity(store.loading ? 1 : 0), alignment: .center)
        .onAppear { if !store.loading { load() } }
    }


    /// load data
    func load() {
        store.load(params: ["page" : "*"]) {
            print("do something after loading")
        }
    }
}
