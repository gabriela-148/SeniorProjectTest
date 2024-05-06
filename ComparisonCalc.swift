//
//  ComparisonCalc.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI
import Charts

struct ComparisonCalc: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    @State private var showError = false
    
    // Takes list of food items from preivous screens
    let item_list: [Food_Item]
    
    var body: some View {
        
        VStack {
            List {
                // Loop through items in cart and displays their information similar to InfoScreen
                ForEach(item_list, id: \.self) { item in
                    VStack {
                        Text(item.name)
                            .font(.headline)
                            .padding(.top, 8)
                            
                        
                        HStack { // carbon and water footprint next to each other
                            VStack { // carbon
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: CGFloat(item.carbonFP * 5)) // Adjust multiplier as needed
                                    .cornerRadius(5)
                                    
                                
                                Text("Carbon Footprint")
                                    .font(.headline)
                                    .padding(.top, 8)
                                
                                Text("\(item.carbonFP) pounds of CO2/kg")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                                    .multilineTextAlignment(.center)
                            }
                            
                            Spacer() // Add Spacer to ensure even alignment
                            
                            VStack { // water
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: CGFloat(item.waterFP)) // Adjust multiplier as needed
                                    .cornerRadius(5)
                                    
                                
                                Text("Water Footprint")
                                    .font(.headline)
                                    .padding(.top, 8)
                                
                                Text("\(item.waterFP) L of water/kg")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                                    .multilineTextAlignment(.center)
                                
                            }//water vstack
                        }//h stack
                        Spacer()
                        
                        Text("The purpose of these values are to educate you on the environmental impact that fast food has the environment.")
                                    .font(.subheadline)
                                    .padding()
                                    .border(Color.black, width: 1)
                                    .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Text("Equivalency Values")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        Text("Eating a \(item.name) is the same as burning \(item.carbonFP/20) gallons of gas while driving a car.") // Divided by 20 bc 20 gallons of CO2 in one gallon of gas
                            .font(.subheadline)
                            .padding(.bottom, 8)
                        Text("Eating a \(item.name) is the same as drinking \(String(format: "%.f", item.waterFP/0.5)) 12 oz. bottles of water.") // Divided by 0.5 bc 0.5L of water in a regular size plastic water bottle
                            .font(.subheadline)
                            .padding(.bottom, 8)
                        
                        Spacer()
                       
                    }
                    .padding()
                } // for each
            } // list
            
            // Checks if the cart is empty first, if not continue otherwise return error alert
            Button {
                if !viewModel.calculationOrder.isEmpty {
                    viewModel.addPoints(username: viewModel.email)
                } else {
                    showError = true
                }
                
            } label: {
                Text("Add Rewards Points")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius:10))
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error!"), message: Text("Calculation cart is empty!"))
            }
            
        }// vstack
    }//body view
}

