//
//  SeniorProjectTestApp.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/6/24.
//

import SwiftUI

@main
struct SeniorProjectTestApp: App {
    // Starting view for the application
    // Initializes the LoginController class so can have access to SQL database
        // and users can log in
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
