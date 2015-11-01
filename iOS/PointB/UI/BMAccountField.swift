//
//  BMAccountField.swift
//  PointB
//
//  Created by Bohui Moon on 10/26/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 * BMAccountField is a UITextField that allows for easy configuration on placholder text, underline (or bottom-border),
 * and contains a UILabel that shows when an alert message needs to be shown.
 */
@IBDesignable
class BMAccountField: UITextField
{
    var alerted: Bool = false
    var duration: NSTimeInterval = 0.3
    
    @IBOutlet var label: UILabel?
    var labelHeight: NSLayoutConstraint?
    
    
    //MARK: Visuals
    private let underline = CALayer()
    
    @IBInspectable var underlineWidth: CGFloat = 1.f
    {
        didSet
        {
            underline.frame = CGRectMake(0, self.height - underlineWidth, self.width, underlineWidth)
        }
    }
    
    @IBInspectable var underlineColorNormal: UIColor = COLOR_FAINT_WHITE
    {
        didSet
        {
            if (!selected && !alerted)
            {
                underline.backgroundColor = underlineColorNormal.CGColor
            }
        }
    }
    
    @IBInspectable var underlineColorSelected: UIColor = UIColor.whiteColor()
    {
        didSet
        {
            if (selected && !alerted)
            {
                underline.backgroundColor = underlineColorSelected.CGColor
            }
        }
    }
    
    @IBInspectable var underlineColorAlerted: UIColor = COLOR_ORANGE
    {
        didSet
        {
            if (alerted)
            {
                underline.backgroundColor = underlineColorAlerted.CGColor
            }
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = COLOR_FAINT_WHITE
    {
        didSet
        {
            if (placeholder != nil)
            {
                self.attributedPlaceholder = NSAttributedString.init(string:placeholder!, attributes:[NSForegroundColorAttributeName:placeholderColor])
            }
        }
    }


    //MARK: - Init
    /**
     * Called by IB to initialize this field at run-time.
     */
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.addSublayer(underline)
        
        self.addTarget(self, action:"dismissAlert", forControlEvents:UIControlEvents.EditingChanged)
    }
    
    /**
     * Called when field is programmatically created.
     * IB also uses this to layout any @IBInspectables during design time
     */
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.layer.addSublayer(underline)
        
        self.addTarget(self, action:"dismissAlert", forControlEvents:UIControlEvents.EditingChanged)
    }
    
    /**
     * Called by nib-loading structure after view has been created and setup.
     * Set the height constraint for the associated label if one exists.
     */
    override func awakeFromNib()
    {
        labelHeight = label?.constraintForAttribute(NSLayoutAttribute.Height)
    }
    
    
    //MARK: UI Control
    /**
     * Called when this field gains focus.
     * Indicate focus by turning underline to selected,
     * but dismiss any alert states beforehand.
     */
    override func becomeFirstResponder() -> Bool
    {
        if (alerted){ dismissAlert() }
        underline.backgroundColor = underlineColorSelected.CGColor
        
        return super.becomeFirstResponder()
    }
    
    /**
     * Called when this field loses focus.
     * Indicate loss of focus by turning underline back to normal,
     * unless field is alerted: in which case it should retain alert state.
     */
    override func resignFirstResponder() -> Bool
    {
        if (!alerted)
        {
            underline.backgroundColor = underlineColorNormal.CGColor
        }
        return super.resignFirstResponder()
    }
    
    
    //MARK: Alerting
    /**
     * Change to alert state by changing underline color to the preset.
     * The color is changed regardless of field's current selection state,
     * and when the user begins editing again, will dismiss alert state.
     */
    func alert()
    {
        alerted = true
        underline.backgroundColor = underlineColorAlerted.CGColor
    }
    
    /**
     * Identical to alert(), but changes the text and shows associated messageLabel if it exists.
     */
    func alert(message: String, duration: NSTimeInterval = DEFAULT_DURATION)
    {
        alert()
        
        self.duration = duration
        
        label?.text = message
        labelHeight?.constant = 30
        UIView.animateWithDuration(duration)
        {
            self.superview?.layoutIfNeeded()
        }
    }
    
    /**
     * Dismiss alert state by changing underline color back to preset for current state,
     * and retract any labels back to hidden state.
     */
    func dismissAlert()
    {
        alerted = false
        if (isFirstResponder())
        {
            underline.backgroundColor = underlineColorSelected.CGColor
        }
        else
        {
            underline.backgroundColor = underlineColorNormal.CGColor
        }
        
        labelHeight?.constant = 0
        UIView.animateWithDuration(duration)
        {
            self.superview?.layoutIfNeeded()
        }
    }
}
