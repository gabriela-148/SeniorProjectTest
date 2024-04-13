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
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        NavigationStack {
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
