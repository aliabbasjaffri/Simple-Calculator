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
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        print("touched \(digit) digit" )
    }
}

