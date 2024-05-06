//
//  ContentView.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/6/24.
//

import SwiftUI
import SQLite3
import Foundation

struct ContentView: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        NavigationStack {
            // if user is signed in, automatically changes the screen to Home
            // else sends user to SignInScreen
            if viewModel.isSignedIn {
                HomeScreen()
                    .environmentObject(viewModel)
            } else {
                SignInScreen()
                    .environmentObject(viewModel)
            }
        }.navigationBarHidden(true)
    }
    
    
}

#Preview {
    ContentView()
}
