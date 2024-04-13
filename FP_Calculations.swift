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

