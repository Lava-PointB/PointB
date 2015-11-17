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
    
    private let MAGIC_RATIO: CGFloat = 0.25


    //MARK: Outlets
    @IBOutlet var logo: UIImageView!
    @IBOutlet var logoRatio: NSLayoutConstraint!
    @IBOutlet var logoHeight: NSLayoutConstraint!
    @IBOutlet var logoOffset: NSLayoutConstraint!
    
    @IBOutlet var logoText: UIImageView!
    @IBOutlet var logoTextRatio: NSLayoutConstraint!
    @IBOutlet var logoTextHeight: NSLayoutConstraint!

    
    @IBOutlet var tabs: UIView!
    @IBOutlet var loginTab: UIButton!
    @IBOutlet var signupTab: UIButton!
    @IBOutlet var underline: UIView!
        var alignLogin: NSLayoutConstraint!
        var alignSignup: NSLayoutConstraint!
    
    @IBOutlet var widget: UIScrollView!
        @IBOutlet var loginBox: UIView!
            @IBOutlet var loginUsername: BMAccountField!
            @IBOutlet var loginPassword: BMAccountField!
            @IBOutlet var passwordReset: UIButton!
        @IBOutlet var signupBox: UIScrollView!
            @IBOutlet var signupEmail: BMAccountField!
            @IBOutlet var signupFirst: BMAccountField!
            @IBOutlet var signupLast:  BMAccountField!
            @IBOutlet var signupUsername: BMAccountField!
            @IBOutlet var signupPassword: BMAccountField!
    @IBOutlet var widgetOffset: NSLayoutConstraint!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var toolbarOffset: NSLayoutConstraint!
    
    
    //MARK: IVARS
    private var keyboardShown = false
    private var loginSelected = true

    private var currentField: BMAccountField?
    private var lastLoginField: BMAccountField?
    private var lastSignupField: BMAccountField?
    
    
    
    //MARK: - Init
    /**
     * Called when view has been loaded.
     * Initialize any programmatic connections.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lastLoginField = loginUsername
        lastSignupField = signupEmail
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name:UIKeyboardWillHideNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name:UIKeyboardWillShowNotification, object:nil)
    }
    
    /**
     *
     */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        adjustUI()
    }
    
    /**
     * Adjust any UI not possible through Storyboard.
     */
    func adjustUI()
    {
        self.setNeedsStatusBarAppearanceUpdate()
        
        //widget
        let height = (SCREEN_SIZE.width * MAGIC_RATIO) * (1 / logoRatio.multiplier)
        logoOffset.constant = (SCREEN_SIZE.height * MAGIC_RATIO) - (height / 2)
        logoHeight.constant = height
        logoTextHeight.constant = height * (0.3).f
        
        //tabs
        alignLogin = NSLayoutConstraint.init(item: underline, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: loginTab, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        alignSignup = NSLayoutConstraint.init(item: underline, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: signupTab, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        tabs.addConstraint(alignLogin)
        
        //widget
        let bottom = (SCREEN_SIZE.height - widget.height) * MAGIC_RATIO
        widgetOffset.constant = bottom
        
        //name division
        let rightBorder = CALayer()
        rightBorder.frame = CGRectMake(signupFirst.width - 1, 0, 1, signupFirst.height)
        rightBorder.backgroundColor = COLOR_WHITE.CGColor
        signupFirst.layer.addSublayer(rightBorder)
        
        signupLast.leftView = UIView(frame: CGRectMake(0, 0, 10, signupLast.height))
        signupLast.leftViewMode = UITextFieldViewMode.Always
        
        
        //toolbar
        let clearImage = UIImage.imageWithColor(UIColor.clearColor())
        toolbar.setShadowImage(clearImage, forToolbarPosition: UIBarPosition.Any)
        toolbar.setBackgroundImage(clearImage, forToolbarPosition:UIBarPosition.Any, barMetrics:UIBarMetrics.Default)
        toolbar.alpha = 0.0
    }
    
    
    //MARK: UI Control
    /**
     * Prefer to hide the status bar entirely
     */
    override func prefersStatusBarHidden() -> Bool
    {
        return true
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
        nextButton.title = "Login"
        
        
        //animation
        tabs.removeConstraint(alignSignup)
        tabs.addConstraint(alignLogin)
        
        UIView.animateWithDuration(DEFAULT_DURATION,
        animations: {
            self.view.layoutIfNeeded()
            self.widget.contentOffset = CGPointMake(0, 0)
        },
        completion: { (success: Bool) in
            self.lastLoginField?.becomeFirstResponder()
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
        nextButton.title = "Sign up"
        
        //animation
        tabs.removeConstraint(alignLogin)
        tabs.addConstraint(alignSignup)
        
        UIView.animateWithDuration(DEFAULT_DURATION,
        animations: {
            self.view.layoutIfNeeded()
            self.widget.contentOffset = CGPointMake(self.widget.width, 0)
        },
        completion: { (success: Bool) in
            self.lastSignupField?.becomeFirstResponder()
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
        //let remaining = SCREEN_SIZE.height - kbFrame.size.height
        
        //calc
        let bottom = kbFrame.height + toolbar.height + 10
        let remain = SCREEN_SIZE.height - tabs.height - widget.height - bottom
        let height = (remain * 0.4 >= 50) ? (remain * 0.4) : 0
        let top = (remain * 0.4) - (height / 2)
        
        //animation
        logoOffset.constant = top
        logoHeight.constant = height
        logoTextHeight.constant = height * (0.3).f
        
        widgetOffset.constant = bottom
        toolbarOffset.constant = kbFrame.height
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
        
        //calc
        let bottom = (SCREEN_SIZE.height - widget.height) * MAGIC_RATIO
        let height = (SCREEN_SIZE.width * MAGIC_RATIO) * (1 / logoRatio.multiplier)
        let top = (SCREEN_SIZE.height * MAGIC_RATIO) - (height / 2)
        
        //animation
        logoOffset.constant = top
        logoHeight.constant = height
        logoTextHeight.constant = height * (0.3).f
        
        widgetOffset.constant = bottom
        toolbarOffset.constant = 0
        
        UIView.animateWithDuration(duration)
        {
            self.toolbar.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    /**
    * Switch focus to the given text field by making it become first responder,
    * and apply any necessary animations beforehand.
    */
    func focus(textField: UITextField, duration: NSTimeInterval = 0)
    {
        var widgetOffset = widget.contentOffset
        var signupOffset = signupBox.contentOffset
        
        if (textField == loginUsername || textField == loginPassword)
        {
            widgetOffset = CGPointMake(0, 0)
        }
        else if (textField == signupEmail)
        {
            widgetOffset = CGPointMake(widget.width, 0)
            signupOffset = CGPointMake(0, 0)
        }
        else if (textField == signupFirst || textField == signupLast || textField == signupUsername)
        {
            widgetOffset = CGPointMake(widget.width, 0)
            signupOffset = CGPointMake(signupBox.width, 0)
        }
        else if (textField == signupPassword)
        {
            widgetOffset = CGPointMake(widget.width, 0)
            signupOffset = CGPointMake(2 * signupBox.width, 0)
        }
        
        UIView.animateWithDuration(duration,
            animations:{
                self.widget.contentOffset = widgetOffset
                self.signupBox.contentOffset = signupOffset
            },
            completion:{ (success:Bool) in
                textField.becomeFirstResponder()
        })
    }
    
    
    //MARK: Actions
    /**
     * Called when user presses the fogot password button.
     * Relay message to Parse to send a password change email.
     */
    @IBAction func passwordResetPressed(sender: AnyObject?)
    {
        //TODO: password reset email
    }
    
    /**
     * Called when a text field becomes the first responder for editing.
     * Store a reference to the field for when widget mode is changed (login/signup)
     */
    func textFieldDidBeginEditing(textField: UITextField)
    {
        let field = textField as! BMAccountField
        currentField = field
        
        var next = "Next"
        
        switch (field)
        {
            case loginUsername: lastLoginField = loginUsername
            case loginPassword:
                next = "Login"
                lastLoginField = loginPassword
            
            case signupEmail: lastSignupField = signupEmail
            case signupFirst: lastSignupField = signupFirst
            case signupLast : lastSignupField = signupLast
            case signupUsername: lastSignupField = signupUsername
            case signupPassword:
                next = "Sign up"
                lastSignupField = signupPassword
            
            default: break;
        }
        
        nextButton.title = next
    }
    
    /**
     * Called when user hits the return key on a
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        nextPressed(self)
        return true
    }
    
    /**
     * Called when user presses the back button.
     */
    @IBAction func backPressed(sender: AnyObject?)
    {
        switch (currentField!)
        {
            case loginPassword: focus(loginUsername)
            
            case signupFirst: focus(signupEmail, duration: DEFAULT_DURATION)
            case signupLast : focus(signupFirst)
            case signupUsername: focus(signupLast)
            case signupPassword: focus(signupUsername, duration: DEFAULT_DURATION)
            
            default: break
        }
    }
    
    /**
     * Called when user presses the Login/Sign up button.
     * Depending on the currently selected widget mode, call appropriate functions
     */
    @IBAction func nextPressed(sender: AnyObject?)
    {
        switch (currentField!)
        {
            case loginUsername: focus(loginPassword)
            case loginPassword: login()
                
            case signupEmail: checkEmail()
            case signupFirst: focus(signupLast)
            case signupLast: focus(signupUsername)
            case signupUsername: checkUsername()
            case signupPassword: signup()
                
            default: break;
        }
    }
    
    
    //MARK: Account
    /**
     *
     */
    func login()
    {
        loginUsername.dismissAlert()
        loginPassword.dismissAlert()
    
        var stop = false
        if (loginUsername.text!.isEmpty)
        {
            loginUsername.alert()
            stop = true
        }
        
        if (loginPassword.text!.isEmpty)
        {
            loginPassword.alert()
            stop = true
        }
        
        //end if some kind of error
        if (stop) { return }
        
        
        var username = loginUsername.text!
        let password = loginPassword.text!
        
        //if logging in with email
        if (username.isUSCEmail())
        {
            PFCloud.callFunctionInBackground("userByEmail", withParameters: ["email":username])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: get user for email")
                    return
                }
                
                if (object != nil)
                {
                    username = (object as! PFUser).username!
                    return
                }
                
                self.focus(self.signupFirst, duration: DEFAULT_DURATION)
            }
        }
        
        //login
        PFUser.logInWithUsernameInBackground(username, password: password)
        { (user: PFUser?, error: NSError?) in
            if (error != nil)
            {
                //error handling
                self.widget.shakeX(8.f, breakFactor:0.85.f, duration:0.5, maxShakes:3)
                print(error)
                return
            }
            
            //success
            self.performSegueWithIdentifier("toMain", sender: self)
        }
    }
    
    /**
     * Check if the enetered email is a valid USC email and if it's already registered.
     * Inidicate to user any errors, or move onto first name field if valid.
     */
    func checkEmail()
    {
        let email = signupEmail.text!
        
        if (!email.isUSCEmail())
        {
            signupEmail.alert("That's not a USC email!")
            return
        }
        
        PFCloud.callFunctionInBackground("userByEmail", withParameters: ["email":email])
        { (object: AnyObject?, error: NSError?) in
            if (error != nil)
            {
                self.signupEmail.alert("Error while checking email...")
                return
            }
            
            if (object != nil)
            {
                self.signupEmail.alert("Registered email!")
                return
            }
            
            self.focus(self.signupFirst, duration: DEFAULT_DURATION)
        }
    }
    
    /**
     * Check if the entered username for signup is already taken.
     * Indicate to user it's taken if so, or move onto signupPassword if valid.
     */
    func checkUsername()
    {
        let username = signupUsername.text!
    
        PFCloud.callFunctionInBackground("userByUsername", withParameters: ["username":username])
        { (object: AnyObject?, error: NSError?) in
            if (error != nil)
            {
                self.signupUsername.alert("Error while checking username...")
                return
            }
            
            if (object != nil)
            {
                self.signupUsername.alert("Sorry that one's taken!")
                return
            }
            
            self.focus(self.signupPassword, duration: DEFAULT_DURATION)
        }
    }
    
    func signup()
    {
        if (signupFirst.text!.isEmpty)
        {
            signupFirst.alert()
            focus(signupFirst, duration: DEFAULT_DURATION)
            return
        }
        
        if (signupLast.text!.isEmpty)
        {
            signupLast.alert()
            focus(signupLast, duration: DEFAULT_DURATION)
            return
        }
        
        
        //all fields valid
        let newUser = PFUser()
        newUser.email = signupEmail.text!
        newUser.username = signupUsername.text!
        newUser.password = signupPassword.text!
        
        newUser["firstName"] = signupFirst.text!
        newUser["lastName"] = signupLast.text!
        
        newUser.signUpInBackgroundWithBlock()
        { (success: Bool, error: NSError?) -> Void in
            if (error != nil || !success)
            {
                self.signupPassword.alert("Error while signing up...")
                return
            }
            
            //success
            self.performSegueWithIdentifier("toMain", sender: self)
        }
    }
}















