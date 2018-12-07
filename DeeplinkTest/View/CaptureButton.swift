//
//  CaptureButton.swift
//  DeeplinkTest
//
//  Created by Macmini on 12/6/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

let buttonBorderWidth: CGFloat = 6

@IBDesignable
class CaptureButton: UIButton {
    var pathLayer:CAShapeLayer!
    let animationDuration = 0.4
    
    @IBInspectable var borderWidth: CGFloat = buttonBorderWidth
    @IBInspectable var isPhotoButton: Bool = false {
        didSet {
            if let pathLayer = self.pathLayer {
                if isPhotoButton {
                    pathLayer.fillColor = UIColor.white.cgColor
                }
                else {
                    pathLayer.fillColor = UIColor.red.cgColor
                }
                isSelected = false
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup()
    {
        self.pathLayer = CAShapeLayer()
        self.pathLayer.path = self.currentInnerPath().cgPath
        self.pathLayer.strokeColor = nil
        self.layer.addSublayer(self.pathLayer)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute:.width,
                                              relatedBy:.equal,
                                              toItem:nil,
                                              attribute:.width,
                                              multiplier:1,
                                              constant: self.bounds.size.width))
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute:.height,
                                              relatedBy:.equal,
                                              toItem:nil,
                                              attribute:.width,
                                              multiplier:1,
                                              constant:  self.bounds.size.width))
        
        self.setTitle("", for:UIControl.State.normal)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: UIControl.Event.touchDown)
    }
    
    
    override func prepareForInterfaceBuilder()
    {
        self.setTitle("", for:UIControl.State.normal)
    }

    override var isSelected:Bool{
        didSet{
            if !isPhotoButton { // that means video button
                let pathAnimation = CABasicAnimation(keyPath: "path")
                pathAnimation.duration = animationDuration;
                pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                
                pathAnimation.toValue = self.currentInnerPath().cgPath
                
                pathAnimation.fillMode = CAMediaTimingFillMode.forwards
                pathAnimation.isRemovedOnCompletion = false
                
                self.pathLayer.add(pathAnimation, forKey:"")
            }
        }
    }
    
    @objc func touchUpInside(sender:UIButton)
    {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
            pathLayer.opacity = 1.0
        CATransaction.commit()
        
        self.isSelected = !self.isSelected
    }
    
    @objc func touchDown(sender:UIButton)
    {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
            pathLayer.opacity = 0.5
        CATransaction.commit()
    }
    
    override func draw(_ rect: CGRect) {
        let outerRing = UIBezierPath(ovalIn: CGRect(x: borderWidth/2, y: borderWidth/2, width: self.bounds.size.width-borderWidth , height: self.bounds.size.height-borderWidth))
        outerRing.lineWidth = borderWidth
        UIColor.white.setStroke()
        outerRing.stroke()
    }
    
    func currentInnerPath () -> UIBezierPath
    {
        var returnPath:UIBezierPath;
        if (self.isSelected)
        {
            returnPath = self.innerSquarePath()
        }
        else
        {
            returnPath = self.innerCirclePath()
        }
        
        return returnPath
    }
    
    func innerCirclePath () -> UIBezierPath
    {
        let innerRadius =  (self.bounds.size.width - borderWidth) / 1.2
        let offset = (self.bounds.size.width - innerRadius) / 2
        return UIBezierPath(roundedRect: CGRect(x: offset, y: offset, width: innerRadius, height: innerRadius), cornerRadius: innerRadius / 2)
    }
    
    func innerSquarePath () -> UIBezierPath
    {
        let innerRadius =  (self.bounds.size.width - borderWidth) / 2
        let offset = (self.bounds.size.width - innerRadius) / 2
        return UIBezierPath(roundedRect: CGRect(x: offset, y: offset, width: innerRadius, height: innerRadius), cornerRadius: 5)
    }
}
