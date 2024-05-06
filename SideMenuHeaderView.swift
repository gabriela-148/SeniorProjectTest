//
//  SideMenuHeaderView.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI
// Code received form GitHub
struct SideMenuHeaderView: View {
    @EnvironmentObject var viewModel: LoginController
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius:10))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("\(viewModel.name)")
                    .font(.subheadline)
                
                Text("\(viewModel.email)")
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
