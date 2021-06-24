//
//  SidebarView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 01.06.2021.
//


import SwiftUI
import Data
import Service
import Ui

/// Main tool panel with controlls
struct SidebarView<U : Store>: View, Stylable, Supportable, Controllable {
    
    typealias Item = MenuSection
    
    /// Logger service
    @EnvironmentObject var logger: Logger
    
    /// Store with data
    @StateObject var store: U
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    /// The type of view representing the body of this view
    var body: some View {
        NavigationView {
            controlRender()
        }
        .preferredColorScheme(.dark)
        .onAppear(perform: afterRender)
        .mask(!notLoading, text: "loading menu", border: false)
    }
    
    // MARK: - Private methods
    
    /// Define component body depends on a request results
    /// - Returns: Component body
    @ViewBuilder
    private func controlRender() -> some View{
        if store.count() > 0 {
            buildComponentBody()
        } else {
            if store.error != nil { ErrorView(store.error!) }
            else { EmptyData() }
        }
    }
    
    /// Get View
    /// - Returns: Vview
    @ViewBuilder
    private func buildComponentBody() -> some View {
        List {
            Group {
                Spacer()
                NavigationLink(destination: MainView(title: "Main", imageName:"person")) { Label("Main", systemImage: "house")}
                if let elms = store.items as? [Item]{
                    buildListBody(elms)
                }
                
                Button(action: { authentication.signOut() }) {
                    Label("Sign Out", systemImage: "arrow.backward").padding(15.0)
                }.buttonStyle(PlainButtonStyle())
            }
            .listRowBackground(isMac ? Color.clear : componentRGB)
            .padding(.leading, 15)
        }
        .frame(minWidth: isMac ? 200 : 0)
        .listStyle(SidebarListStyle())
        .navigationTitle("Pick up a board")
        .background(backgroundRGB)
        
        MainView(title: "Main", imageName: "house")
    }
    
    /// List body builder
    /// - Parameter data: Data  [String: [ListItem]]
    /// - Returns: List body View
    @ViewBuilder
    private func buildListBody(_ data: [MenuSection]) -> some View {
        ForEach(data, id: \.self) { section in
            Text(section.title).font(.system(.title3))
            ForEach(section.items, id: \.self) { item in
                NavigationLink(
                    destination: MainView(title: item.title, imageName: item.imageName)){
                    Label(item.title,systemImage: item.imageName)
                }
            }
        }
        Divider()
    }
    
    /// Do after component is rendered
    private func afterRender(){
        #if os(iOS)
        UITableView.appearance().backgroundColor = uiBackgroundColor
        UITableViewCell.appearance().backgroundColor = uiBackgroundColor
        #endif
    }
}





