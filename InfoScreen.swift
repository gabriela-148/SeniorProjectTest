//
//  InfoScreen.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI
import Charts

struct InfoScreen: View {
    
    @EnvironmentObject var viewModel: LoginController
    let item: Food_Item
    
    //@ObservedObject var model = LoginController()
    var body: some View {
        
        VStack {
            HStack {
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
                
            }
            
            Section {
                List {
                    Text("\(item.name) : \(item.carbonFP) pounds")
                    Text("\(item.name) : \(item.waterFP) L")
                }
               
                    
            }//section
            //.searchable(text: $searchText, prompt: "Enter a name") /for later
            
        }// vstack
    }
}

