import SwiftUI

struct InfoScreen: View {
    let item: Food_Item

    var body: some View {
        VStack {
            // Displays name of burger to get info 
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
                
                // Water footprint display
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
            
            // Reminder of importance of these calculations to the user
            Text("The purpose of these values are to educate you on the environmental impact that fast food has the environment.")
                        .font(.subheadline)
                        .padding()
                        .border(Color.black, width: 1)
                        .multilineTextAlignment(.center)
            
            Spacer()
            
            // Values to help user understand significance of the footprints in terms easily understood
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
    }
}
