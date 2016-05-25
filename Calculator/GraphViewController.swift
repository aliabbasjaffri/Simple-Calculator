//
//  GraphViewController.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 22/05/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController
{
    @IBOutlet weak var graphView: GraphView!{
        didSet
        {
            let tapGesture = UITapGestureRecognizer(target: graphView, action: #selector(GraphView.tapGesture))
            tapGesture.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapGesture)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(GraphView.panGesture))
            graphView.addGestureRecognizer(panGesture)
            
            let pinchGesture = UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.pinchGesture))
            graphView.addGestureRecognizer(pinchGesture)
        }
    }
    
}
