//
//  CircularProfileView.swift
//  GetSwifter
//

//

import UIKit
import QuartzCore


class CircularProfileView: UIView {

    
    var imageLayer : CALayer!
    var image : UIImage? {
    
        didSet{updateLayerProperties()}
    }
    
 
    
    var lineWidth : Double = 10.0 {
    
        didSet{
        
            updateLayerProperties()
        }
        
    }
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
   
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
    
                if (imageLayer != nil){
            
                if let i = image {
                imageLayer.contents = i.CGImage
                }
            }
          
        
        }

    

    
    
    
    
    
}
