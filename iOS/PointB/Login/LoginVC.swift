//
//  LoginVC.swift
//  PointB
//
//  Created by Bohui Moon on 10/24/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import Foundation

/**
 * LoginVC is the ViewController for the login/sign up screen.
 * For first time and non-logged in users, this will be the landing screen.
 */
class LoginVC: UIViewController, UITextFieldDelegate
{
    //MARK: Constants
    private let MESSAGE_HEIGHT: CGFloat = 30
    private let MINIMUM_HEIGHT: CGFloat = 300
    private let SCREEN_SIZE = UIScreen.mainScreen().bounds.size
    
    private let LOGO_OFFSET_RATIO: CGFloat = 0.10
    private let WIDGET_OFFSET_RATIO: CGFloat = 0.10
    
    private let LOGO_HEIGHT_RATIO: CGFloat = 0.15
    private let LOGO_TEXT_HEIGHT_RATIO: CGFloat = 0.05


    //MARK: Outlets
    @IBOutlet var logoOffset: NSLayoutConstraint!
    @IBOutlet var widgetOffset: NSLayoutConstraint!
    
    @IBOutlet var logoHeight: NSLayoutConstraint!
    @IBOutlet var logoTextHeight: NSLayoutConstraint!
    
    
    @IBOutlet var widget: UIView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var loginUsernameField: BMAccountField!
    @IBOutlet var loginPasswordField: BMAccountField!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    
    //MARK: IVARS
    private var keyboardShown = false
    private var loginSelected = true
    
    
    
    //MARK: - Init
    /**
     * Called when view has been loaded.
     * Initialize any progmatically connections.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        adjustUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name:UIKeyboardWillHideNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name:UIKeyboardWillShowNotification, object:nil)
    }
    
    /**
     * Adjust any UI not possible through Storyboard.
     */
    func adjustUI()
    {
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.logoOffset.constant = SCREEN_SIZE.height * LOGO_OFFSET_RATIO
        self.widgetOffset.constant = SCREEN_SIZE.height * WIDGET_OFFSET_RATIO
        
        self.logoHeight.constant = SCREEN_SIZE.height * LOGO_HEIGHT_RATIO
        self.logoTextHeight.constant = SCREEN_SIZE.height * LOGO_TEXT_HEIGHT_RATIO
    }
    
    
    //MARK: UI Control
    /**
     * Set the preferred status bar style for this login page as white content
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    /**
     * Called when user touches anywhere on the screen.
     * End any textfield currently editing.
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    /**
     * Called by notification center when the keyboard is about to show.
     * Only accept the call if keyboard is not already shown.
     * Adjust autolayout so that the same ratios are applied to remaing space (screen height - keyboard).
     */
    func keyboardWillShow(notification:NSNotification!)
    {
        if (keyboardShown) { return }
        keyboardShown = true
        
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let kbFrame = self.view.convertRect(info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
        let remaining = SCREEN_SIZE.height - kbFrame.size.height
        
        //animation
        self.logoHeight.constant = remaining * LOGO_HEIGHT_RATIO
        self.logoTextHeight.constant = remaining * LOGO_TEXT_HEIGHT_RATIO
        
        self.logoOffset.constant = remaining * LOGO_OFFSET_RATIO
        self.widgetOffset.constant = remaining * WIDGET_OFFSET_RATIO
        
        if (remaining < MINIMUM_HEIGHT)
        {
            //if widget is still covered after adjusting
            //make text disappear
            self.logoTextHeight.constant = 0
            
            self.logoOffset.constant = 20
            self.widgetOffset.constant = 0
        }
        
        UIView.animateWithDuration(duration)
        {
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     * Called by notification center when the keyboard is about to hide.
     * Only accept the call if keyboard is currently showing.
     * Adjust the autolayout so that the ratios are applied back to the full screen height.
     */
    func keyboardWillHide(notification:NSNotification!)
    {
        if (!keyboardShown) { return }
        keyboardShown = false
        print("keyboard hide")
        
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double

        
        //animation
        self.logoHeight.constant = SCREEN_SIZE.height * LOGO_HEIGHT_RATIO
        self.logoTextHeight.constant = SCREEN_SIZE.height * LOGO_TEXT_HEIGHT_RATIO
        
        self.logoOffset.constant = SCREEN_SIZE.height * LOGO_OFFSET_RATIO
        self.widgetOffset.constant = SCREEN_SIZE.height * WIDGET_OFFSET_RATIO
        UIView.animateWithDuration(duration)
        {
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     * Called when user presses the login tab button.
     */
    @IBAction func loginPressed(sender: AnyObject?)
    {
        if (loginSelected) { return }
        loginSelected = true
        
        loginButton.setTitleColor(COLOR_WHITE, forState:UIControlState.Normal)
        signupButton.setTitleColor(COLOR_FAINT_WHITE, forState:UIControlState.Normal)
        
        loginUsernameField.becomeFirstResponder()
    }
    
    /**
     * Called when user presses the sign up tab button.
     */
    @IBAction func signupPressed(sender: AnyObject?)
    {
        if (!loginSelected) { return }
        loginSelected = false
        
        loginButton.setTitleColor(COLOR_FAINT_WHITE, forState:UIControlState.Normal)
        signupButton.setTitleColor(COLOR_WHITE, forState:UIControlState.Normal)
        
        
    }
    
    
    
    //MARK: TextField Delegate
    func textFieldDidBeginEditing(textField: UITextField)
    {
        let field:BMAccountField = textField as! BMAccountField
        field.underlineColor = COLOR_WHITE
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        let field:BMAccountField = textField as! BMAccountField
        field.underlineColor = COLOR_FAINT_WHITE
    }
}















