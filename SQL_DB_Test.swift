//
//  SQL_DB_Test.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/24/24.
//

import Foundation
import SQLite
import UIKit

// Code gotten from GitHub
enum SideMenuOptionModel: Int, CaseIterable {
    case dashboard
    case pickTwo
    case burgers
    case settings
    
    var title: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .pickTwo:
            return "Pick Two"
        case .burgers:
            return "Burgers"
        case .settings:
            return "Settings"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .dashboard:
            return "house"
        case .pickTwo:
            return "2.square"
        case .burgers:
            return "fork.knife"
        case .settings:
            return "gear"
        }
    }
}
extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}

class LoginController: ObservableObject {
    
    // Variables to be changed with database calls in funcitons below
    @Published var isSignedIn = false // changes view in real time
    @Published var name = ""
    @Published var email = ""
    @Published var userPoints = 0 // resets user points to 0 after each login - need to figure out how to save in program - ik its saved in DB
    
    @Published var foodList = [Food_Item]()
    @Published var calculationOrder = [Food_Item]()
    @Published var userList = [User]()
    
    @Published var currID: Int = -1
    
    
    func getUserPoints(email: String) -> Int {
        var pointValue: Int = 0
        
        do {
            // Path to the SQLite database file
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            // Define the table and columns
            let users = Table("usersList")
            let storedUsername = Expression<String>("email")
            let storedPoints = Expression<Int>("totalPoints")
            
            // Construct the query to select points for the specified email
            let pointsQuery = users.select(storedPoints).filter(storedUsername == email)
            
            // Execute the query and try to fetch the user's points
            if let user = try db.pluck(pointsQuery) {
                // User found, retrieve the points value
                pointValue = try user.get(storedPoints)
                print("Current points: \(pointValue)")
                
            } else {
                // User not found, print an error message
                print("User with email '\(email)' not found")
            }
        } catch {
            // Handle any errors that occur during database operations
            print("Error: \(error)")
        }
        
        // Return the points value associated with the user
        return pointValue
    }

    // Add rewards points based on footprint of the item in cart
    func addPoints(username: String) {
        do {
            // Path to the SQLite database file
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)

            // Define table structure and columns
            let users = Table("usersList")
            let storedPoints = Expression<Int>("totalPoints")
            let storedUsername = Expression<String>("email")

            // Calculate points for the current item
            
            let calculatedPoints = calculationOrder.reduce(0) { $0 + getPoints(water: $1.waterFP, carbon: $1.carbonFP) }

            // Fetch the current user's total points
            let currentUserQuery = users.filter(storedUsername == username)
            guard let currentUser = try db.pluck(currentUserQuery) else {
                print("User with email '\(username)' not found")
                return
            }
            let currentPoints = try currentUser.get(storedPoints)

            // Update the user's total points with the new calculated points
            let updatedPoints = currentPoints + calculatedPoints
            let updateQuery = users.filter(storedUsername == username).update(storedPoints <- updatedPoints)
            
            // Execute the update query
            if try db.run(updateQuery) == 1 {
                self.userPoints = updatedPoints
                print("Points updated successfully for user \(username)")
            } else {
                print("Failed to update points for user \(username)")
            }

        } catch {
            print("Error: \(error)")
        }
    }



    // Adds item to cart
    func addToCalc(item: Food_Item) {
        calculationOrder.append(item)
    }
    
    // Removes item from cart
    func removeFromCalc(item: Food_Item) {
        calculationOrder.removeAll { $0 == item }
    }
    
    // Signs out user in real time
    func signOut() {
        self.isSignedIn = false
    }
    
    // Returns the email String of the current user logged in
    func getEmailOfUser() -> String? {
        do {
            // Path to the SQLite database file
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            // Define the table and column
            let users = Table("usersList")
            let emailColumn = Expression<String>("email")
            
            // Fetch the first row from the 'usersList' table
            if let user = try db.pluck(users.select(emailColumn)) {
                // Extract and return the email from the row
                return try user.get(emailColumn)
            } else {
                // If no row is found, return nil
                return nil
            }
        } catch {
            // Handle any errors that occur during database operations
            print("Error: \(error)")
            return nil
        }
    }

    // Changes the password for the current user as long as their old pwd matches
    func resetPassword(username: String, newPassword: String, oldPassword: String) -> Bool {
        var success = false
        // Path to the SQLite database file
        let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
        do {
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            let users = Table("usersList")
            let storedUsername = Expression<String>("email")
            let storedPassword = Expression<String>("password")
            
            let userQuery = users.filter(username == storedUsername && storedPassword == oldPassword)
            
                
            if let user = try db.pluck(userQuery) {
                let updateUser = users.filter(username == storedUsername)
                        .update(storedPassword <- newPassword)
                try db.run(updateUser)
                
                success = true
            }
            
            
        } catch {
            print("Error: \(error)")
        }
        return success
    }
    
    // Checks the input in the user database to login the user to the app
    func login(username: String, password: String) -> Bool {
        var success = true
        
        // Path to the SQLite database file
        let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
        do {
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            let users = Table("usersList")
            let storedUsername = Expression<String>("email")
            let storedID = Expression<Int>("id")
            let storedPassword = Expression<String>("password")
            let storedName = Expression<String>("name")
            let storedPoints = Expression<Int>("totalPoints")
            
            let query = users.select(storedName)
                .filter(storedUsername == username && storedPassword == password)
            
            let emailQuery = users.select(storedUsername)
            
            let pointsQuery = users.select(storedPoints)
            
            if let user = try db.pluck(query) {
                // Login successful
                success = true
                
                self.isSignedIn = true
                self.name = user[storedName]
                self.email = getEmailOfUser() ?? "testing"
                self.foodList = fetchFoodItems()
                // Fetch all rows from the 'food_items' table
                for item in try db.prepare(users) {
                    // Create Food_Item instance for each row and append to foodItemList
                    let currUser = User(name: item[storedName],
                                        email: item[storedUsername],
                                        pwd: item[storedPassword],
                                        id: item[storedID],
                                        points: item[storedPoints])
                    userList.append(currUser)
                }
            
            }
            
            // If query was successfully executed, store the correct information
            if let user2 = try db.pluck(emailQuery) {
                success = true
                
                self.email = user2[storedUsername]
            }
            
            if let user3 = try db.pluck(pointsQuery) {
                success = true
                self.userPoints = user3[storedPoints]
            }
            
            
        } catch {
            print("Error: \(error)")
        }
        return success
    }//end login function
    
    //function to get weights in db
    func getWeights() {
        // Define your SQLite database connection
        do {
        let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
        let db = try Connection(dbPath)

        // Define table structure and columns
        let food_items = Table("food")
        let storedWeight = Expression<Double>("weight") // Assuming the 'weight' column is of type REAL in SQLite

        
            // Fetch a single row from the 'food_items' table
            for item in try db.prepare(food_items) {
                // Retrieve the 'weight' column value and cast it to Double
                let weight: Double = try item.get(storedWeight)
                
                // Now 'weight' contains the value of the 'weight' column as a Double
                print("Weight: \(weight)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    // Function to fetch rows from SQLite database and store them in a list
    func fetchFoodItems() -> [Food_Item] {
        calcCarbonFP()
        calcWaterFP()
        
        var foodItemList = [Food_Item]()
        
        do {
            // Path to the SQLite database file
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            // Define table structure and columns
            let food_items = Table("food")
            let storedFoodName = Expression<String>("name")
            let storedRestaurant = Expression<String>("restaurant")
            let storedWeight = Expression<Double>("weight")
            let storedCarbon = Expression<Double>("carbonFP")
            let storedWater = Expression<Double>("waterFP")
            let storedPoints = Expression<Double>("pointValue")
            
            // Fetch all rows from the 'food_items' table
            for item in try db.prepare(food_items) {
                // Create Food_Item instance for each row and append to foodItemList
                let foodItem = Food_Item(name: item[storedFoodName],
                                         rest: item[storedRestaurant],
                                         weight: item[storedWeight],
                                         id: item[storedPoints],
                                         imageName: item[storedFoodName],
                                         carbonFP: item[storedCarbon],
                                         waterFP: item[storedWater])
                foodItemList.append(foodItem)
            }
        } catch {
            print("Error: \(error)")
        }
        return foodItemList
    }
    
    // Calculates all the water footprints for items in the database
    func calcWaterFP() {
        do {
            // Define your SQLite database connection
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            let db = try Connection(dbPath)

            // Define table structure and columns
            let foodItems = Table("food") // Corrected table name to match the variable name
            let storedWater = Expression<Double>("waterFP")
            let storedFoodName = Expression<String>("name")
            let storedWeight = Expression<Double>("weight")

            // Update the 'carbonFP' column for each row in the 'food_items' table
            for item in try db.prepare(foodItems) {
                // Calculate carbon FP value based on 'name' and 'weight' columns
                let name = try item.get(storedFoodName)// Assuming there's a 'name' column
                let weight = try item.get(storedWeight) // Assuming there's a 'weight' column
                let waterValue : Double
                
                if name == "McChicken" {
                    waterValue = ( 4.325 ) * (weight)
                } else if name == "Impossible Whoppper" {
                    waterValue = 106.8
                } else {
                    waterValue = ( 15.415 ) * (weight)
                }
                
                // Update 'carbonFP' column with the calculated value
                let updateQuery = foodItems.filter(storedFoodName == name)
                    .update(storedWater <- waterValue)
                try db.run(updateQuery)
                
                print("Water FP for \(name): \(waterValue)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    // Calculates all the carbon footprints for items in the database
    func calcCarbonFP() {
        
        do {
            // Define your SQLite database connection
            let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
            let db = try Connection(dbPath)

            // Define table structure and columns
            let foodItems = Table("food") // Corrected table name to match the variable name
            let storedCarbon = Expression<Double>("carbonFP")
            let storedFoodName = Expression<String>("name")
            let storedWeight = Expression<Double>("weight")

            // Update the 'carbonFP' column for each row in the 'food_items' table
            for item in try db.prepare(foodItems) {
                // Calculate carbon FP value based on 'name' and 'weight' columns
                let name = try item.get(storedFoodName)// Assuming there's a 'name' column
                let weight = try item.get(storedWeight) // Assuming there's a 'weight' column
                let carbonValue : Double
                
                if name == "McChicken" {
                    carbonValue = (1.26 / 4) * weight
                } else if name == "Impossible Whopper" {
                    carbonValue = 6.61 * 0.2
                } else {
                    carbonValue = (6.61 / 4) * weight
                }
            
                

                // Update 'carbonFP' column with the calculated value
                let updateQuery = foodItems.filter(storedFoodName == name)
                    .update(storedCarbon <- carbonValue)
                try db.run(updateQuery)
                
                print("Carbon FP for \(name): \(carbonValue)")
            }
        } catch {
            print("Error: \(error)")
        }
    }



    // Returns all the records in the tables in teh database
    func getAllTables() {
        // Path to the SQLite database file
        let dbPath = Bundle.main.path(forResource: "mydatabase", ofType: "db")!
        
        do {
            // Establish a connection to the SQLite database
            let db = try Connection(dbPath)
            
            // Define table structure and columns
            let users = Table("usersList")
            let name = Expression<String>("name")
            let items = Table("food_items")
            let food_name = Expression<String>("name")
            
            // Fetch all rows from the 'users' table and print them to the console
            for user in try db.prepare(users) {
                print("Name: \(user[name])")
            }
            for item in try db.prepare(items) {
                print("Item: \(item[food_name])")
            }
        } catch {
            print("Error: \(error)")
        }
    }// end get all tables func
}//end of class
