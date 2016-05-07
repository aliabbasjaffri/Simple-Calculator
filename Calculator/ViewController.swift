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
    
    private var userIsInTheMiddleOfTyping = false
    private var userHasEnteredADecimalPoint = false
    
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
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
        }
        else
        {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton)
    {
        userHasEnteredADecimalPoint = false
        
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(mathematicalSymbol)
            displayValue = brain.result
        }
    }
    @IBAction func touchDecimal(sender: UIButton)
    {
        if !userHasEnteredADecimalPoint
        {
            display.text! += "."
            userHasEnteredADecimalPoint = true
        }
    }
    @IBAction func saveToMemory(sender: UIButton)
    {
        
    }
    
    @IBAction func getFromMemory(sender: UIButton)
    {
        
    }
}

