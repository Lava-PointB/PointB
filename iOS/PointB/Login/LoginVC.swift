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



    //MARK: Outlets
    @IBOutlet var tabs: UIView!
    @IBOutlet var loginTab: UIButton!
    @IBOutlet var signupTab: UIButton!
    @IBOutlet var underline: UIView!
        var alignLogin: NSLayoutConstraint!
        var alignSignup: NSLayoutConstraint!
    
    @IBOutlet var widget: UIScrollView!
        @IBOutlet var loginUsername: BMAccountField!
        @IBOutlet var loginPassword: BMAccountField!
        @IBOutlet var passwordReset: UIButton!
    @IBOutlet var widgetOffset: NSLayoutConstraint!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var toolbarOffset: NSLayoutConstraint!
    
    
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
        
        //tabs
        alignLogin = NSLayoutConstraint.init(item: underline, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: loginTab, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        alignSignup = NSLayoutConstraint.init(item: underline, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: signupTab, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        tabs.addConstraint(alignLogin)
        
        //widget
        widgetOffset.constant = SCREEN_SIZE.height * 0.3
        
        //toolbar
        let clearImage = UIImage.imageWithColor(UIColor.clearColor())
        toolbar.setShadowImage(clearImage, forToolbarPosition: UIBarPosition.Any)
        toolbar.setBackgroundImage(clearImage, forToolbarPosition:UIBarPosition.Any, barMetrics:UIBarMetrics.Default)
        toolbar.alpha = 0.0
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
    * Called when user presses the login tab button.
    */
    @IBAction func loginPressed(sender: AnyObject?)
    {
        if (loginSelected) { return }
        loginSelected = true
        
        loginTab.setTitleColor(COLOR_WHITE, forState: UIControlState.Normal)
        signupTab.setTitleColor(COLOR_FAINT_WHITE, forState: UIControlState.Normal)
        widget.setContentOffset(CGPointMake(0, 0), animated: true)
        
        tabs.removeConstraint(alignSignup)
        tabs.addConstraint(alignLogin)
        
        UIView.animateWithDuration(0.3,
        animations: {
            self.view.layoutIfNeeded()
        },
        completion: { (success: Bool) in
            self.loginUsername.becomeFirstResponder()
        })
    }
    
    /**
    * Called when user presses the sign up tab button.
    */
    @IBAction func signupPressed(sender: AnyObject?)
    {
        if (!loginSelected) { return }
        loginSelected = false
        
        loginTab.setTitleColor(COLOR_FAINT_WHITE, forState: UIControlState.Normal)
        signupTab.setTitleColor(COLOR_WHITE, forState: UIControlState.Normal)
        widget.setContentOffset(CGPointMake(widget.width, 0), animated:true)
        
        tabs.removeConstraint(alignLogin)
        tabs.addConstraint(alignSignup)
        
        UIView.animateWithDuration(0.3,
        animations: {
            self.view.layoutIfNeeded()
        },
        completion: { (success: Bool) in
            
        })
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
        self.toolbarOffset.constant = kbFrame.height
        
        self.widgetOffset.constant = kbFrame.height + toolbar.height + 10
        UIView.animateWithDuration(duration)
        {
            self.toolbar.alpha = 1
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
        
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let kbFrame = self.view.convertRect(info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
        
        //animation
        self.toolbarOffset.constant = 0
        
        self.widgetOffset.constant = 200
        UIView.animateWithDuration(duration)
        {
            self.toolbar.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: Account
    @IBAction func passwordResetPressed(sender: AnyObject?)
    {
        
    }
}















