//
//  CartCalc.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct CartCalc: View {
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        List(viewModel.calculationOrder) { item in
            CartRow(item: item)
        }
        
        
        NavigationLink(destination: ComparisonCalc()) {
            Text("Calculate")
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(width: 100, height: 50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius:10))
        }
    }
}

#Preview {
    CartCalc()
}
