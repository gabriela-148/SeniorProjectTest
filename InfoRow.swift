//
//  InfoRow.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/23/24.
//

import SwiftUI

struct InfoRow: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    let item: Food_Item
    
    var body: some View {
        HStack {
            Image(item.imageName.lowercased())//need to change to item.imageName and store link to DB
                .resizable()
                .frame(width: 110, height: 110, alignment: .trailing)
            
            Text(item.name)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
        }
        .frame(height: 125)
    }
}

