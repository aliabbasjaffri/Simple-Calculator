//
//  ViewController.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 22/04/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet private weak var display: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var userHasEnteredADecimalPoint = false
    private var userHasPressedEqualsSign = false
    private var userHasEnteredAMathematicalSymbol = false
    private var isPartialResult = false
    
    private var lastEnteredDigit = 0.0
    
    private var brain = CalculatorBrain()
    
    private var displayValue : Double
    {
        get
        {
            return Double(display!.text!)!
        }
        set
        {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        lastEnteredDigit = Double(digit)!
        
        if userHasPressedEqualsSign
        {
            clear()
            userHasPressedEqualsSign = false
        }
        
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
            descriptionLabel.text! += digit
        }
        else
        {
            if descriptionLabel.text! == "0"
            {
                descriptionLabel.text! = ""
            }
            
            display.text = digit
            descriptionLabel.text! += " " + digit
        }
        userIsInTheMiddleOfTyping = true
        userHasEnteredAMathematicalSymbol = false
    }
    
    @IBAction private func performOperation(sender: UIButton)
    {
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            
            if userHasPressedEqualsSign
            {
                var temp = descriptionLabel.text!
                temp = temp.stringByReplacingOccurrencesOfString("=", withString: "")
                descriptionLabel.text! = temp
            }
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            if mathematicalSymbol == "="
            {
                userIsInTheMiddleOfTyping = true
                userHasPressedEqualsSign = true
                descriptionLabel.text! += " ="
            }
            else if mathematicalSymbol == "+" || mathematicalSymbol == "-" || mathematicalSymbol == "x" || mathematicalSymbol == "÷"
            {
                descriptionLabel.text! += " " + mathematicalSymbol
                userHasPressedEqualsSign = false
                userHasEnteredAMathematicalSymbol = true
            }
            else if mathematicalSymbol == "cos" || mathematicalSymbol == "e" || mathematicalSymbol == "√" || mathematicalSymbol == "π"
            {
                descriptionLabel.text! = mathematicalSymbol + String(displayValue)
            }
            
            brain.performOperation(mathematicalSymbol)
            displayValue = brain.result
        }
    }
    
    @IBAction func touchDecimal(sender: UIButton)
    {
        if !userHasEnteredADecimalPoint
        {
            display.text! += "."
            descriptionLabel.text! += "."
            userHasEnteredADecimalPoint = true
        }
    }
    
    @IBAction func saveToMemory(sender: UIButton)
    {
        descriptionLabel.text! = "→M"
        brain.memory = displayValue
    }
    
    @IBAction func getFromMemory(sender: UIButton)
    {
        descriptionLabel.text! = "M ="
        displayValue = brain.memory
    }
    
    @IBAction func clearButton(sender: UIButton)
    {
        clear()
    }
    
    func clear()
    {
        brain.clear()
        displayValue = 0
        display.text! = "0"
        descriptionLabel.text! = "0"
    }
}

