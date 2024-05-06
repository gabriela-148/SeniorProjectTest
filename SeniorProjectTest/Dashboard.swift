//
//  Dashboard.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct Dashboard: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Displays users name
                Text("Hi, \(viewModel.name)!")
                    .font(.headline)
                    .padding()
                
                // Displays the user's current rewards balance in progress bar
                Section(header: Text("Rewards Balance").padding()) {
                    ProgressView(value: Double(viewModel.getUserPoints(email: viewModel.getEmailOfUser() ?? "testing")), total: 5000) // Create a ProgressView with the current progress value
                        .progressViewStyle(LinearProgressViewStyle()) // Use LinearProgressViewStyle for a horizontal progress bar
                        .padding(8)
                    
                    // Points value
                    Text("Total Points: \(viewModel.getUserPoints(email: viewModel.getEmailOfUser() ?? "testing"))")
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                        .padding(8)
                        .multilineTextAlignment(.center)
                   
                }
                
                // Description of ecological footprints
                Text("What is a carbon footprint?\nThe total amount of greenhouse gases, \nspecifically carbon dioxide that is emitted either directly or \nindirectly because of a human activity.")
                    .font(.subheadline)
                    .padding(8)
                    .border(Color.black, width: 1)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                
                Text("What is a water footprint?\nThe measure of the total volume of freshwater\n used to produce goods or services that are consumed by a indiviudal.")
                    .font(.subheadline)
                    .padding(8)
                    .border(Color.black, width: 1)
                    .multilineTextAlignment(.center)
                    
                Spacer()
            }
            
            Spacer() // Add spacer to push content to the top
        }
        Spacer()
    }
    
}


