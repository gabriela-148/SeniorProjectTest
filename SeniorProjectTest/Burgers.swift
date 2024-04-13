//
//  Burgers.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/23/24.
//

import SwiftUI

struct Burgers: View {
    @EnvironmentObject var viewModel: LoginController
    //@ObservedObject var model = LoginController()
    var body: some View {
        VStack {
            Section {
                List(viewModel.foodList){ item in
                    NavigationLink(destination: InfoScreen(item: item)) {
                        InfoRow(item: item)
                    }
                    
                }//list
            }//section
            //.searchable(text: $searchText, prompt: "Enter a name") /for later
            
        }// vstack
    }
}

#Preview {
    Burgers()
}
