//
//  User.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 4/13/24.
//

import Foundation
// User data struct that stores data from usersList table in SQL Database
// Allows to store data from DB and check inputs from user
struct User: Identifiable, Hashable {
    
    
    var name: String
    var email: String
    var pwd: String
    var id: Int
    var points: Int
    
}
