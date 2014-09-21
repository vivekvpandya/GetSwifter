//
//  CircularProfileView.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/21/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit
import QuartzCore


class CircularProfileView: UIView {

    
    var imageLayer : CALayer!
    var image : UIImage? {
    
        didSet{updateLayerProperties()}
    }
    
   // var backgroundRingLayer  : CAShapeLayer!
   // var ringLayer : CAShapeLayer!
    
    var lineWidth : Double = 10.0 {
    
        didSet{
        
            updateLayerProperties()
        }
        
    }
    
   /* var rating : Double = 0.6 {
    
        didSet{
        updateLayerProperties()
        }
        
    } */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
     /*   if (backgroundRingLayer == nil) {
        
        backgroundRingLayer = CAShapeLayer()
        layer.addSublayer(backgroundRingLayer)
         
            let lw2 = lineWidth / 2.0
            let rect = CGRectInset( bounds,CGFloat(lw2),CGFloat(lw2) )
            
            let path = UIBezierPath(ovalInRect:rect)
            
            backgroundRingLayer.path = path.CGPath
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.lineWidth = 10.0
            backgroundRingLayer.strokeColor = UIColor(white:0.5, alpha:0.3).CGColor
        
        }
        
        backgroundRingLayer.frame = layer.bounds
    
    
    
        if(ringLayer == nil){
        
            ringLayer = CAShapeLayer()
            
            let lw2 = lineWidth / 2.0
            
            let innerRect = CGRectInset(bounds, CGFloat(lw2) , CGFloat(lw2))
            
            let innerPath = UIBezierPath(ovalInRect:innerRect)

            ringLayer.path = innerPath.CGPath
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.blueColor().CGColor
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, -CGFloat(M_PI)/2, 0, 0, 1)

            layer.addSublayer(ringLayer)
        }
    ringLayer.frame = layer.bounds
        
        */
        if (imageLayer == nil){
            
            let imageMaskLayer = CAShapeLayer()
            let lw3 = lineWidth + 3.0
            
            let insetBounds = CGRectInset(bounds, CGFloat(lw3) , CGFloat(lw3))
            let innerPath = UIBezierPath(ovalInRect: insetBounds)
            
            imageMaskLayer.path = innerPath.CGPath
            imageMaskLayer.fillColor = UIColor.blackColor().CGColor
            imageMaskLayer.frame = bounds
            layer.addSublayer(imageMaskLayer)
            imageLayer = CALayer()
            imageLayer.mask = imageMaskLayer
            imageLayer.frame = bounds
            imageLayer.backgroundColor = UIColor.lightGrayColor().CGColor
            imageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
            
            
            
        }
    updateLayerProperties()
    
    }
    
    func updateLayerProperties(){
    
     /*   if (ringLayer != nil) {
        ringLayer.strokeEnd = CGFloat(rating)
            
            
            var strokColor = UIColor.lightGrayColor()
            switch rating{
            
            case let r where r >= 2000.0:
                strokColor = UIColor(hue: 112.0 / 360.0 , saturation:0.39 , brightness:0.85, alpha:1.0 )
            case let r where r >= 1000.0:
                strokColor = UIColor(hue: 208.0 / 360.0 , saturation:0.51 , brightness:0.75, alpha:1.0 )
            case let r where r >= 500.0:
                strokColor = UIColor(hue: 40.0 / 360.0 , saturation:0.39 , brightness:0.85, alpha:1.0 )
            default:
                strokColor = UIColor(hue: 359.0 / 360.0 , saturation:0.48 , brightness:0.63, alpha:1.0 )
                
                
            }
        
            ringLayer.strokeColor = strokColor.CGColor
           */
            if (imageLayer != nil){
            
                if let i = image {
                imageLayer.contents = i.CGImage
                }
            }
          
        
        }
    
    //}
    

    
    
    
    
    
}
