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
    let content: (T, CGFloat) -> Content
    
    /// View title
    let title: String?
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// Load data from the remote source onAppear
    var autoLoad: Bool = false
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack(alignment: .topLeading) {
            getToolBar()
            getChartBody()
        }.frame(height: 150, alignment: .topLeading)
        .mask(store.loading)
        .border(Color.white)
        .onAppear { if notLoading { load() } }
    }
    
    
    /// Get Item width
    /// - Parameter proxy: Geometry reader proxy
    /// - Returns: Width
    private func getItemWidth(_ proxy: GeometryProxy) -> CGFloat{
        proxy.size.width / CGFloat(store.count()) - 16.0
    }
    
    /// - Returns: chart
    @ViewBuilder
    private func getChartBody() -> some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: 0) {
                if store.error != nil { Text("\(store.error!)").foregroundColor(.red) }
                else {
                    if store.items.count > 0 {
                        ForEach(store.items, id: \.self) { item in
                            content(item, getItemWidth(proxy))
                        }
                    } else {
                        Text("Empty")
                    }
                }
            }.opacity(store.loading ? 0 : 1).offset(y: 50)
            .frame(height: 100, alignment: .bottomLeading)
        }
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
        store.load(params: ["page": "*"]) {
            print("do something after loading")
        }
    }
}
