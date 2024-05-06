//
//  PickTwo.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct PickTwo: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Lists of items of the foodList using the ItemRow UI
                List(viewModel.foodList) { item in
                    ItemRow(item: item)
                }
                // Users can go to cart after adding items
                NavigationLink(destination: CartCalc()) {
                    Text("Go to Cart")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 50)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius:10))
                }
                
                
            }
        }
        
        
    }
}

#Preview {
    PickTwo()
}
