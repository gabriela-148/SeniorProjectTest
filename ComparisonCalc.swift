//
//  ComparisonCalc.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI
import Charts

struct ComparisonCalc: View {
    
    @EnvironmentObject var viewModel: LoginController
    
    let item_list: [Food_Item]
    
    var body: some View {
        
        VStack {
            List {
                ForEach(item_list, id: \.self) { item in
                    HStack {
                        
                        VStack {
                            Chart {
                                BarMark(x:PlottableValue.value("Sandwich", item.name) , y: .value("Pounds of CO2", item.carbonFP) )
                                    .annotation( position: .overlay) {
                                        Text("\(item.carbonFP)")
                                            .foregroundColor(.black)
                                    }
                                    .foregroundStyle(.red)
                            }
                            Chart {
                                BarMark(x:PlottableValue.value("Sandwich", item.name) , y: .value("Liters of Water", item.waterFP) )
                                    .annotation(position: .overlay) {
                                        Text("\(item.waterFP)")
                                            .foregroundColor(.white)
                                    }
                            }
                            .chartXAxis(Visibility.visible)
                            .chartYAxis(Visibility.visible)
                        }//v stack
                    }// h stack
                    .padding()
                } // for each
            } // list
            
            Button {
                viewModel.addPoints(username: viewModel.email)
            } label: {
                Text("Add Rewards Points")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius:10))
            }
            
            
        }// vstack
    }//body view
}

