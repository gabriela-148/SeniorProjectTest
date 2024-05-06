//
//  CartCalc.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct CartCalc: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    @State private var showError = false
    
    var body: some View {
        // Lists all item in order
        List(viewModel.calculationOrder) { item in
            CartRow(item: item)
        }
        
        // Navigates user to comparison screen with cart items
        NavigationLink(destination: ComparisonCalc(viewModel: _viewModel, item_list: viewModel.calculationOrder)) {
            // Checks if cart is empty before continuing and shows error if cart is empty
            Button(action: {
                if !viewModel.calculationOrder.isEmpty {
                    viewModel.addPoints(username: viewModel.email)
                } else {
                    showError = true
                }
            }) {
                Text("Calculate")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius:10))
            }
        }
        // Presents alert when error is true
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text("Calculation order is empty!"),
                dismissButton: .default(Text("OK"))
            )
        }


    }
}

#Preview {
    CartCalc()
}
