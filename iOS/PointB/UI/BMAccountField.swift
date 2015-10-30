//
//  BMAccountField.swift
//  PointB
//
//  Created by Bohui Moon on 10/26/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

@IBDesignable
class BMAccountField: UITextField
{
    //MARK: Constants
    

    //MARK: ivars
    private let underline:CALayer = CALayer()
    
    @IBOutlet private var height: NSLayoutConstraint!
    
    //MARK: IBInspectables
    @IBInspectable var underlineColor:UIColor = UIColor.clearColor()
    {
        didSet
        {
            underline.backgroundColor = underlineColor.CGColor
        }
    }
    
    @IBInspectable var underlineThickness:CGFloat = 0
    {
        didSet
        {
            let size = self.bounds.size
            underline.frame = CGRectMake(0, size.height - underlineThickness, size.width, underlineThickness)
        }
    }
    
    @IBInspectable var placeholderColor:UIColor?
    {
        didSet
        {
            let text = self.placeholder
            if (text != nil)
            {
                let info = [NSForegroundColorAttributeName:placeholderColor!]
                self.attributedPlaceholder = NSAttributedString.init(string:text!, attributes:info)
            }
        }
    }
    
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        print("init with coder height:\(height)")
        self.layer.addSublayer(underline)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        print("init with frame frame:\(self.frame)")
        self.layer.addSublayer(underline)
    }
    
    override func awakeFromNib() {
        print("awake from nib height:\(height)")
    }
}
