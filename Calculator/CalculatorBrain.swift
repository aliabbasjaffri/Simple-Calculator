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
    
    var operations : Dictionary<String , Operations> = [
        "π" : Operations.Constant(M_PI),
        "e" : Operations.Constant(M_E),
        "cos" : Operations.UnaryOperation,
        "√" : Operations.UnaryOperation
        ]
    
    enum Operations
    {
        case Constant(Double)
        case UnaryOperation
        case BinaryOperation
        case Equals
    }
    
    func setOperand( operand: Double )
    {
        accumulator = operand
    }
    
    func performOperation( symbol : String )
    {
        if let operation = operations[symbol]
        {
            switch operation
            {
            case .Constant(let value) : accumulator = value
            case .BinaryOperation : break
            case .UnaryOperation : break
            case .Equals : break
            }
        }
    }
    
    var result : Double{
        get
        {
            return accumulator
        }
    }
}
