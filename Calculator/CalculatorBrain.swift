//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 23/04/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    var accumulator = 0.0
    
    func setOperand( operand: Double )
    {
        accumulator = operand
    }
    
    func performOperation( symbol : String )
    {
        
    }
    
    var result : Double{
        get
        {
            return accumulator
        }
    }
}
