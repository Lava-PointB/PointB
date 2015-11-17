//
//  Extensions.swift
//  PointB
//
//  Created by Bohui Moon on 10/29/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import Foundation


extension Int
{
    var f: CGFloat { return CGFloat(self) }
}

extension Float
{
    var f: CGFloat { return CGFloat(self) }
}

extension Double
{
    var f: CGFloat { return CGFloat(self) }
}


//MARK: -
extension String
{
    func isUSCEmail() -> Bool
    {
        let uscRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@(?i)usc.edu"
        let predicate = NSPredicate(format: "SELF MATCHES %@", uscRegex)
        
        return predicate.evaluateWithObject(self)
    }
}



//MARK: -
@IBDesignable extension UIView
{
    //inspectable ui
    @IBInspectable var cornerRadius: CGFloat
    {
        get {
            return layer.cornerRadius
        }
        set(newVal) {
            layer.cornerRadius = newVal
            layer.masksToBounds = newVal > 0
            clipsToBounds = newVal > 0
        }
    }

    //frame
    var x: CGFloat
    {
        get { return self.frame.origin.x }
        set(newX) { self.frame.origin.x = newX }
    }
    
    var y: CGFloat
    {
        get { return self.frame.origin.y }
        set(newY) { self.frame.origin.y = newY }
    }

    var width: CGFloat
    {
        get { return self.frame.size.width }
        set(newWidth) { self.frame.size.width = newWidth }
    }

    var height: CGFloat
    {
        get { return self.frame.size.height }
        set(newHeight) { self.frame.size.height = newHeight }
    }
    
    
    //constraints
    func constraintForAttribute(attribute: NSLayoutAttribute) -> NSLayoutConstraint?
    {
        let constraints = self.constraints
        let filtered = constraints.filter(){ $0.firstAttribute == attribute }
        
        if (filtered.isEmpty)
        {
            return nil
        }
        return filtered[0]
    }
    
    //animations
    ///https://github.com/jonasschnelli/UIView-I7ShakeAnimation/blob/master/UIView%2BI7ShakeAnimation.m
    func shakeX(var offset: CGFloat, breakFactor: CGFloat, duration: NSTimeInterval, var maxShakes: NSInteger)
    {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = duration
        
        var keys = [NSValue]()
        while (offset > 0.01 && maxShakes > 0)
        {
            keys.append(NSValue(CGPoint: CGPointMake(self.center.x - offset, self.center.y)))
            offset *= breakFactor
            
            keys.append(NSValue(CGPoint: CGPointMake(self.center.x + offset, self.center.y)))
            offset *= breakFactor
            
            maxShakes--
        }
        
        animation.values = keys
        self.layer.addAnimation(animation, forKey:"position")
    }
}


//MARK: -
extension UIImage
{
    //http://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
    class func imageWithColor(color: UIColor) -> UIImage
    {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


extension UITableViewCell
{
    override public var layoutMargins: UIEdgeInsets
    {
        get
        {
            return UIEdgeInsetsZero
        }
        set (newValue)
        {
            super.layoutMargins = newValue
        }
    }
}



