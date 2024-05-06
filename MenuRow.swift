//
//  MenuRow.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/23/24.
//

import SwiftUI

import SwiftUI

struct ItemRow: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    @State private var showAddAlert = false
    @State var showCart = false
    
    // Takes item from previous screen
    let item: Food_Item
    var body: some View {
        
        // Horizontally stacks images for the list view
        HStack {
            // Image
            Image(item.imageName.lowercased())
                .resizable()
                .frame(width: 110, height: 110, alignment: .trailing)
            // Burger name
            Text(item.name)
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
            
            Spacer()
            // Adds burger to calculationOrder list
            Button {
                viewModel.addToCalc(item: item)
                showAddAlert = true
                showCart = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.red)
            }
            .alert(isPresented: $showAddAlert) {
                Alert(title: Text("Success!"), message: Text("Item added to calculation!"))
            }
        }
        .frame(height: 125)
    }
}

struct CartRow: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    @State private var showRemoveAlert = false
    // Takes item from previous screen
    let item: Food_Item
    var body: some View {
        // Horizontally stacks images for the list view
        HStack {
            // Image
            Image(item.imageName.lowercased())
                .resizable()
                .frame(width: 110, height: 110, alignment: .trailing)
            // Burger name
            Text(item.name)
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
            Spacer()
            // Removes burger to calculationOrder list
            Button {
                viewModel.removeFromCalc(item: item)
                showRemoveAlert = true
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(.red)
            }
            .alert(isPresented: $showRemoveAlert) {
                Alert(title: Text("Success!"), message: Text("Item removed from cart."))
            }
        }
        .frame(height: 125)
    }
}


