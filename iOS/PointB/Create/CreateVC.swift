//
//  CreateVC.swift
//  PointB
//
//  Created by Bohui Moon on 12/3/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 * ### CreateVC
 *
 */
class CreateVC: UIViewController
{
    
    //MARK: Outlets
    @IBOutlet var dialog: UIView!
    @IBOutlet var cancel: UIBarButtonItem!


    //MARK: - Init
    /**
     * Called when view is loaded
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    
    //MARK: UI Control
    /**
     * Render status bar as white while this view is active
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }

    /**
     * Called when user touches anywhere on the screen.
     * If touch is outside of dialog, dimiss this view.
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if ( !CGRectContainsPoint(dialog.bounds, (touches.first?.locationInView(dialog))!) )
        {
            cancelPressed(self)
        }
    }
    
    
    //MARK: Action
    /**
     * Called when user presses the X or outside dialog to cancel
     */
    @IBAction func cancelPressed(sender: AnyObject?)
    {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}








