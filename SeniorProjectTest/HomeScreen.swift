//
//  HomeScreen.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/24/24.
//

import SwiftUI
import SideMenu

struct HomeScreen: View {
    @EnvironmentObject var viewModel: LoginController
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
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
        .toolbar(showMenu ? .hidden: .visible, for: .navigationBar)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showMenu.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: CartCalc()) {
                    Image(systemName: "cart")
                }
            }
        }
        //.padding()
        
    }// body}
    
}//struct


#Preview {
    HomeScreen()
}
