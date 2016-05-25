//
//  GraphView.swift
//  Calculator
//
//  Created by Ali Abbas Jaffri on 23/05/2016.
//  Copyright © 2016 Ali Abbas Jaffri. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func pointsForGraphView(sender: GraphView) -> [CGPoint]
}

@IBDesignable
class GraphView: UIView
{
    @IBInspectable
    var lineWidth : CGFloat = 1.0 { didSet{setNeedsDisplay()} }
    
    @IBInspectable
    var lineColor : UIColor = UIColor.blueColor() { didSet{setNeedsDisplay()} }
    
    @IBInspectable
    var scale: CGFloat = 50.0 {
        didSet {
            updateRange()
            setNeedsDisplay()
        }
    }
    
    weak var dataSource: GraphViewDataSource?
    
    private var rangeMinimumX : CGFloat = -50.0
    private var rangeMaximumX : CGFloat = 50.0
    
    private var rangeMinimumY : CGFloat = -25.0
    private var rangeMaximumY : CGFloat = 25.0
    
    private var increment : CGFloat = 1.0
    
    private var screenCenter : CGPoint {return CGPoint(x: bounds.midX , y: bounds.midY)}
    
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
        let axesDrawer = AxesDrawer(color: lineColor ,contentScaleFactor: contentScaleFactor)
        axesOrigin = screenCenter
        axesDrawer.drawAxesInRect( viewBounds, origin: axesOrigin, pointsPerUnit: scale )
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        lineColor.set()
        
        if var points = dataSource?.pointsForGraphView(self)
        {
            if points.count > 1
            {
                path.moveToPoint(points.removeAtIndex(0))
                
                for point in points
                {
                    path.moveToPoint(point)
                }
            }
        }
        path.stroke()
    }
    
    internal func tapGesture(gesture : UITapGestureRecognizer)
    {
        if gesture.state == .Ended
        {
            axesOrigin = gesture.locationInView(self)
        }
    }
    
    internal func pinchGesture(gesture : UIPinchGestureRecognizer)
    {
        if gesture.state == .Changed
        {
            scale *= gesture.scale
            gesture.scale = 1.0
        }
    }
    
    internal func panGesture(gesture : UIPanGestureRecognizer)
    {
        switch gesture.state
        {
            case .Changed , .Ended:
                let translation = gesture.translationInView(self)
                if translation.x != 0 || translation.y != 0
                {
                    axesOrigin.x += translation.x
                    axesOrigin.y += translation.y
                    gesture.setTranslation(CGPointZero, inView: self)
                }
            default: break
        }
    }

}
