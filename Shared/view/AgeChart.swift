//
//  AgeChart.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import SwiftUI

/// List displays data conformed to Model protocol
struct AgeChart<T: Model, U: Proxy, V: AbstractToolBar, Content: View>: View, StoredView {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// Template to defined Item view
    let content: (T, CGFloat) -> Content       
    
    /// ToolBar with diff controls
    let toolBar: V
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// Load data from the remote source onAppear
    var autoLoad: Bool = false
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack(alignment: .topLeading) {
            toolBar.onPreferenceChange(StateKey.self, perform: self.onStateChanged)
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
                if store.error != nil { ErrorView(store.error!)}
                else {
                    if store.items.count > 0 {
                        ForEach(store.items, id: \.self) { item in
                            content(item, getItemWidth(proxy))
                        }
                    } else { EmptyData() }
                }
            }.offset(y: 50)
            .frame(height: 100, alignment: .bottomLeading)
        }
    }
    
    /// clear data
    func clear(){
        store.removeAll()
    }
    
    /// load data
    func load() {
        store.load(params: ["page": "*"]) {
            print("do something after loading")
        }
    }
}
