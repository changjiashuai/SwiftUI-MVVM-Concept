//
//  AgeChart.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 30.04.2021.
//

import SwiftUI

/// List displays data conformed to Model protocol
struct AgeChart<T: Model, U: Proxy, ToolContent : View, Content: View>: View {
    
    /// Store with data
    @StateObject var store: RemoteStore<T, U>
    
    /// Template to defined Item view
    let content: (T, CGFloat) -> Content
    
    /// ToolBar with set of controls
    let toolBar: ToolContent
    
    /// check condition to start loading
    var notLoading: Bool {
        !store.loading
    }
    
    /// Load data from the remote source onAppear
    var autoLoad: Bool = false
    
    /// The type of view representing the body of this view.
    var body: some View {
        ZStack(alignment: .topLeading) {
            toolBar.onPreferenceChange(StoreCommandKey.self, perform: self.onCommandChanged)
            getChartBody()
        }.frame(height: 150, alignment: .topLeading)
        .mask(!notLoading)
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
        store.load(params: ["page": "*"]) {
            print("do something after loading")
        }
    }
}
