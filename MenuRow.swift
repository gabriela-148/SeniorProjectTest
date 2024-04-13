//
//  MenuRow.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/23/24.
//

import SwiftUI

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var viewModel: LoginController
    @State private var showAddAlert = false
    @State var showCart = false
    
    
    let item: Food_Item
    var body: some View {
        HStack {
            Image(item.imageName.lowercased())//need to change to item.imageName and store link to DB
                .resizable()
                .frame(width: 110, height: 110, alignment: .trailing)
            Text(item.name)
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
            
            Spacer()
            
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
    @EnvironmentObject var viewModel: LoginController
    @State private var showRemoveAlert = false
    
    let item: Food_Item
    var body: some View {
        HStack {
            Image(item.imageName.lowercased())//need to change to item.imageName and store link to DB
                .resizable()
                .frame(width: 110, height: 110, alignment: .trailing)
            Text(item.name)
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
            Spacer()
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


