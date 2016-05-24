//
//  GraphView.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 23/05/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView
{
    var lineWidth : CGFloat = 1.0 { didSet{setNeedsDisplay()} }
    var lineColor : UIColor = UIColor.blueColor() { didSet{setNeedsDisplay()} }
    var scale: CGFloat = 50.0 {
        didSet {
            updateRange()
            setNeedsDisplay()
        }
    }
    
    private var rangeMinimumX : CGFloat = -50.0
    private var rangeMaximumX : CGFloat = 50.0
    
    private var rangeMinimumY : CGFloat = -25.0
    private var rangeMaximumY : CGFloat = 25.0
    
    private var increment : CGFloat = 1.0
    
    private var viewCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    private var axesOrigin: CGPoint = CGPoint(x: 0, y:0 ) {
        didSet {
            updateRange()
            setNeedsDisplay()
        }
    }
    
    // viewBounds passed to AxesDrawer
    private var viewBounds: CGRect {
        return CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: bounds.size
        )
    }
    
    private func updateRange()
    {
        rangeMinimumX = -axesOrigin.x / scale
        rangeMaximumX =  rangeMinimumX + (bounds.size.width / scale)
        increment = (1.0/scale)
        
    }
    
    
    override func drawRect(rect: CGRect)
    {
        let axesDrawer = AxesDrawer(
            color: UIColor.blueColor() ,
            contentScaleFactor: contentScaleFactor
        )
        
        axesOrigin.x = center.x
        axesOrigin.y = center.y
        
        axesDrawer.drawAxesInRect(
            viewBounds,
            origin: axesOrigin,
            pointsPerUnit: scale
        )
    }
    

}
