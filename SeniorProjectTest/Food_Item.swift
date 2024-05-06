//
//  Food_Item.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/23/24.
//

import Foundation

// Creates a Food_item data struct that can store all of the attributes
// listed in the Food table in the SQL database
// Allows for better usability and compatibility across the code files
struct Food_Item: Identifiable, Hashable {
    
    
    var name: String
    var rest: String
    var weight: Double
    var id: Double
    var imageName: String
    var carbonFP: Double
    var waterFP: Double
    
}
