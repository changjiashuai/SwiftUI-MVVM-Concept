//
//  SidebarView.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 01.06.2021.
//


import SwiftUI
import Service
import Ui


/// Main tool panel with controlls
struct SidebarView: View, Stylable {
    
    /// Authentication service
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    Spacer()
                    NavigationLink(destination: MainView(title: "Main")) {
                        Label("Main", systemImage: "house")
                    }
                    Text("DASHBOARD")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                    Group {
                        NavigationLink(destination: MainView(title: "Rate")) {
                            Label("Rate", systemImage: "star")
                        }
                        NavigationLink(destination: MainView(title: "Globe")) {
                            Label("Globe", systemImage: "globe")
                        }
                        NavigationLink(destination: MainView(title: "Link")) {
                            Label("Link", systemImage: "link")
                        }
                        NavigationLink(destination: MainView(title: "Templates")) {
                            Label("Templates", systemImage: "rectangle.stack")
                        }
                    }
                    Divider()
                    
                    Text("PROFILE")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                    Group {
                        NavigationLink(destination: MainView(title: "Account")) {
                            Label("Account", systemImage: "person")
                        }
                        NavigationLink(destination: MainView(title: "Notifications")) {
                            Label("Notifications", systemImage: "bell")
                        }
                        NavigationLink(destination: MainView(title: "Settings")) {
                            Label("Settings", systemImage: "gear")
                        }
                    }
                    Divider()
                    
                    Text("PROFILE")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                    Group {
                        NavigationLink(destination: MainView(title: "Account")) {
                            Label("Account", systemImage: "person")
                        }
                        NavigationLink(destination: MainView(title: "Notifications")) {
                            Label("Notifications", systemImage: "bell")
                        }
                    }
                }.listRowBackground(getListBgColor())
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Pick up a board")
            .background(backgroundRGB)
            
            MainView(title: "Main")
            
        }.preferredColorScheme(.dark)
        .background(backgroundRGB)
    }
    
    // MARK: - Life circle
    
    #if os(iOS)
    init () {
        UITableView.appearance().backgroundColor = uiBackgroundColor
        UITableViewCell.appearance().backgroundColor = uiBackgroundColor
    }
    #endif
    
    // MARK: - Methods
    
    /// Get color
    /// - Returns: Color
    private func getListBgColor() -> Color{
        #if os(iOS)
        return componentRGB
        #elseif os(macOS)
        return Color.clear
        #endif
    }
}





