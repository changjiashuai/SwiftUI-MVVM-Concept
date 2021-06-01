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
                    NavigationLink(destination: MainView(title: "Main", imageName: "person")) {
                        Label("Main", systemImage: "house")
                    }
                    getDashBoard()
                    Divider()
                    getProfile()
                    Divider()
                    getAnalisys()
                    Divider()
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Sign Out", systemImage: "arrow.backward")
                    }.onTapGesture {
                        authentication.signOut()
                    }
                }.listRowBackground(getListBgColor())              
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Pick up a board")
            .background(backgroundRGB)
            .frame(minWidth: 200, idealWidth: 300)
            .toolbar {
                #if os(macOS)
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
                #endif
            }
            
            MainView(title: "Main", imageName: "house")
            
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
            NavigationLink(destination: MainView(title: "Account", imageName: "person")) {
                Label("Account", systemImage: "person")
            }
            NavigationLink(destination: MainView(title: "Notifications", imageName: "bell")) {
                Label("Notifications", systemImage: "bell")
            }
            NavigationLink(destination: MainView(title: "Settings", imageName: "gear")) {
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
            NavigationLink(destination: MainView(title: "Descriptive", imageName: "chart.pie")) {
                Label("Descriptive", systemImage: "chart.pie")
            }
            NavigationLink(destination: MainView(title: "Diagnostic", imageName:"chart.bar")) {
                Label("Diagnostic", systemImage: "chart.bar")
            }
            NavigationLink(destination: MainView(title: "Predictive", imageName:  "flowchart")) {
                Label("Predictive", systemImage: "flowchart")
            }
            NavigationLink(destination: MainView(title: "Prescriptive", imageName:  "chart.bar.doc.horizontal")) {
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
            NavigationLink(destination: MainView(title: "Rate", imageName: "star")) {
                Label("Rate", systemImage: "star")
            }
            NavigationLink(destination: MainView(title: "Globe", imageName:  "globe")) {
                Label("Globe", systemImage: "globe")
            }
            NavigationLink(destination: MainView(title: "Link", imageName:  "link")) {
                Label("Link", systemImage: "link")
            }
            NavigationLink(destination: MainView(title: "Templates", imageName: "rectangle.stack")) {
                Label("Templates", systemImage: "rectangle.stack")
            }
        }
    }
    
    // MARK: - Private methods
    
    /// Get color
    /// - Returns: Color
    private func getListBgColor() -> Color{
        #if os(iOS)
        return componentRGB
        #elseif os(macOS)
        return Color.clear
        #endif
    }
    
    // Toggle Sidebar Function
    private func toggleSidebar() {
        #if os(macOS)
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
    
}





