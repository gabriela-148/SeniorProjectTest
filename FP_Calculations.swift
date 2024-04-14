//
//  FP_Calculations.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 4/6/24.
//

import Foundation
import PythonKit

// Python code
let np = Python.import("numpy")

func getCarbonFP(name: String, weight : any Numeric) -> any Numeric {
    var fp = 0.0
    if name == "McChicken" {
        fp = (1.26 / 4 ) * (weight as! Double)
    } else if name == "Impossible Whopper" {
        fp = (6.61 * 0.2 )
    } else {
        fp = (6.61 / 4 ) * (weight as! Double)
    }
    return fp
            
}

func getWaterFP(name: String, weight: any Numeric) -> any Numeric {
    var fp = 0.0
    if name == "McChicken" {
        fp = ( 4.325 ) * (weight as! Double)
    } else if name == "Impossible Whoppper" {
        fp = 106.8
    } else {
        fp = ( 15.415 ) * (weight as! Double)
    }
    
    return fp
}

func getPoints(water: Double, carbon: Double) -> Int {
    let smallWater = 500.0
    let smallCarbon = 5.0
    let largeWater = 1000.0
    let largeCarbon = 10.0
    
    var pointsToAdd = 0
    
    switch water {
        case 0...smallWater:
            pointsToAdd = pointsToAdd + 100
        case smallWater...largeWater:
            pointsToAdd = pointsToAdd + 50
        default:
            pointsToAdd = pointsToAdd + 5
    }
    
    switch carbon {
        case 0...smallCarbon:
            pointsToAdd = pointsToAdd + 100
        case smallCarbon...largeCarbon:
            pointsToAdd = pointsToAdd + 50
        default:
            pointsToAdd = pointsToAdd + 5
    }
    
    return pointsToAdd
}

