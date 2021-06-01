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
                    }.padding(.bottom, 15)
                    getDashBoard()
                    Divider()
                    getProfile()
                    Divider()
                    getAnalisys()
                }.listRowBackground(getListBgColor())
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Pick up a board")
            .background(backgroundRGB)
            
            MainView(title: "Main")
            
        }.preferredColorScheme(.dark)
    }
    
    // MARK: - Life circle
    
    #if os(iOS)
    init () {
        UITableView.appearance().backgroundColor = uiBackgroundColor
        UITableViewCell.appearance().backgroundColor = uiBackgroundColor
    }
    #endif
    
    // MARK: - Methods
    
    @ViewBuilder
    func getProfile() -> some View{
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
    }
    
    @ViewBuilder
    func getAnalisys() -> some View{
        Text("ANALYSIS")
            .font(.system(size: 10))
            .fontWeight(.bold)
        Group {
            NavigationLink(destination: MainView(title: "Descriptive")) {
                Label("Descriptive", systemImage: "chart.pie")
            }
            NavigationLink(destination: MainView(title: "Diagnostic")) {
                Label("Diagnostic", systemImage: "chart.bar")
            }
            NavigationLink(destination: MainView(title: "Predictive")) {
                Label("Predictive", systemImage: "flowchart")
            }
            NavigationLink(destination: MainView(title: "Prescriptive")) {
                Label("Prescriptive", systemImage: "chart.bar.doc.horizontal")
            }
        }
    }
    
    @ViewBuilder
    func getDashBoard() -> some View{
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
    }
    
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





