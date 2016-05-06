//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 23/04/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import Foundation

func multiply(operandOne : Double , operandTwo : Double) -> (Double)
{
    return operandOne * operandTwo
}

class CalculatorBrain
{
    private var pending : PendingBinaryOperationInfo?
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    typealias PropertyList = AnyObject
    var program : PropertyList
    {
        get
        {
            return internalProgram
        }
        set
        {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]
            {
                for op in arrayOfOps
                {
                    if let operand = op as? Double
                    {
                        setOperand(operand)
                    }
                    else if let operation = op as? String
                    {
                        performOperation(operation)
                    }
                }
            }
        }
    }
    
    func clear()
    {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var operations : Dictionary<String , Operations> = [
        "π" : Operations.Constant(M_PI),
        "e" : Operations.Constant(M_E),
        "cos" : Operations.UnaryOperation(cos),
        "√" : Operations.UnaryOperation(sqrt),
        "x" : Operations.BinaryOperation({$0 * $1}),
        "-" : Operations.BinaryOperation({$0 - $1}),
        "+" : Operations.BinaryOperation({$0 + $1}),
        "÷" : Operations.BinaryOperation({$0 / $1}),
        "=" : Operations.Equals
        ]
    
    enum Operations
    {
        case Constant(Double)
        case UnaryOperation((Double) -> (Double))
        case BinaryOperation((Double,Double) -> (Double))
        case Equals
    }
    
    struct PendingBinaryOperationInfo
    {
        var binaryFunction: (Double,Double) -> (Double)
        var firstOperand: Double
    }
    
    func setOperand( operand: Double )
    {
        internalProgram.append(operand)
        accumulator = operand
    }
    
    func performOperation( symbol : String )
    {
        internalProgram.append(symbol)
        if let operation = operations[symbol]
        {
            switch operation
            {
                case .Constant(let value) :
                    accumulator = value
                case .UnaryOperation(let function) :
                    accumulator = function(accumulator)
                case .BinaryOperation(let function) :
                    executePending()
                    pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                case .Equals : executePending()
            }
        }
    }
    
    func executePending()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand , accumulator)
            pending = nil
        }
    }
    
    func setOperand(variableName: String)
    {
        
    }
    
    var variableValues: Dictionary<String, Double> = [:]
    
    var result : Double{
        get
        {
            return accumulator
        }
    }
}
