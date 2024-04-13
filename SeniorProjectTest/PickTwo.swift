//
//  PickTwo.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct PickTwo: View {
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                List(viewModel.foodList) { item in
                    ItemRow(item: item)
                }
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
