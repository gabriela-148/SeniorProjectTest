//
//  Dashboard.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var viewModel: LoginController
    @State private var progress: Double = 0.5
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(viewModel.name)!")
                    .font(.headline)
                    .padding()
                
                Section(header: Text("Rewards Balance").padding()) {
                    ProgressView(value: progress) // Create a ProgressView with the current progress value
                        .progressViewStyle(LinearProgressViewStyle()) // Use LinearProgressViewStyle for a horizontal progress bar
                        .padding()
                    
                    Button("Increase Progress") {
                        // Example action to increase the progress value
                        withAnimation {
                            progress += 0.1 // Increment the progress value
                        }
                    }.padding()
                    Spacer()
                }
            }
            
            Spacer() // Add spacer to push content to the top
        }
        Spacer()
    }
    
}

#Preview {
    Dashboard()
}
