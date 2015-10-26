//
//  LoginVC.swift
//  PointB
//
//  Created by Bohui Moon on 10/24/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import Foundation

class LoginVC: UIViewController
{
    //MARK: IVARS
    private var keyboardShown = false

    //MARK: Outlets
    
    
    //MARK: - Init
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name:UIKeyboardWillHideNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name:UIKeyboardWillChangeFrameNotification, object:nil)
    }
    
    
    //MARK: UI Control
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification:NSNotification!)
    {
        if (keyboardShown) { return }
        keyboardShown = true
        
        print("keyboard show")
        
//        let info = notification.userInfo!
//        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
//        let kbFame = self.view.convertRect(info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
//        
//
//        UIView.animateWithDuration(duration)
//        {
//            self.view.layoutIfNeeded()
//        }
    }
    
    func keyboardWillHide(notification:NSNotification!)
    {
        if (!keyboardShown) { return }
        keyboardShown = false
        print("keyboard hide")
        
//        let info = notification.userInfo!
//        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
//        let kbFame = self.view.convertRect(info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue, fromView:nil)
//
//        UIView.animateWithDuration(duration)
//        {
//            self.view.layoutIfNeeded()
//        }
    }
    
    
    
    //MARK: LoginVC Delegate
    func attemptLoginWithUsername(username:String, password:String)
    {
        
    }
    
    func attemptSignupWithUsername(username:String, password:String, email:String)
    {
        
    }
}
