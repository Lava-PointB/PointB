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
extension UIView
{
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



