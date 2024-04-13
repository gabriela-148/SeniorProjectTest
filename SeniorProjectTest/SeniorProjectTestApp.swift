//
//  SeniorProjectTestApp.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/6/24.
//

import SwiftUI

@main
struct SeniorProjectTestApp: App {
    let viewModel = LoginController()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environmentObject(viewModel)
            }
            
        }
    }
}
