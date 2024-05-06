//
//  HomeScreen.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/24/24.
//

import SwiftUI
import SideMenu

struct HomeScreen: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) { // Side Menu code
                    Dashboard()
                        .tag(0)
                    
                    PickTwo()
                        .tag(1)
                    
                    Burgers()
                        .tag(2)
                    
                    Settings()
                        .tag(3)
                    
                }
                SideMenuScreen(isShowing: $showMenu, selectedTab: $selectedTab)
            }// vstack
        }
        // Toolbar for side menu and cart screen functionality
        .toolbar(showMenu ? .hidden: .visible, for: .navigationBar)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                // Shows side menu when toggled
                Button(action: {
                    showMenu.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                // Takes user to their "cart" at any time
                NavigationLink(destination: CartCalc()) {
                    Image(systemName: "cart")
                }
            }
        }
        
    }// body}
    
}//struct


#Preview {
    HomeScreen()
}
