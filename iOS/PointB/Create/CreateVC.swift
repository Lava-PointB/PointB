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
class CreateVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //MARK: Constants
    private let CELL_ID = "CreateGroupListCell"
    
    //MARK: iVars
    private var groups: [PFObject]? = nil
    
    
    //MARK: Outlets
    @IBOutlet var dialog: UIView!
        @IBOutlet var bottomOffset: NSLayoutConstraint!
    
    @IBOutlet var cancel: UIBarButtonItem!
    @IBOutlet var create: UIButton!
    
    @IBOutlet var table: UITableView!
    


    //MARK: - Init
    /**
     * Called when view is loaded
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //UI adjustment
        bottomOffset.constant = TAB_BAR_HEIGHT + 12
        self.view.backgroundColor = UIColor.clearColor()
        
        //init
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name:UIKeyboardWillHideNotification, object:nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name:UIKeyboardWillShowNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name:UIKeyboardWillChangeFrameNotification, object:nil)
        
        table.delegate = self
        table.dataSource = self
        
        DataManager.sharedInstance.getUserGroups
        { (groups: [PFObject]?) -> Void in
            self.groups = groups
            print(groups)
            self.table.reloadData()
        }
    }
    
    /**
     * Called when view is about to appear and AutoLayout has been applied
     */
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
        if ( CGRectContainsPoint(dialog.bounds, (touches.first?.locationInView(dialog))!) )
        {
            self.view.endEditing(true)
        }
        else
        {
            //dismiss this view
            cancelPressed(self)
        }
    }
    
    /**
     * Called by notification center when the keyboard is about to show.
     * Only accept the call if keyboard is not already shown.
     * Adjust autolayout so that the same ratios are applied to remaing space (screen height - keyboard).
     */
    func keyboardWillShow(notification:NSNotification!)
    {
        //if (keyboardShown) { return }
        //keyboardShown = true
        
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let kbFrame = self.view.convertRect(info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue, fromView:nil)
        //let remaining = SCREEN_SIZE.height - kbFrame.size.height
        
        //animation
        bottomOffset.constant = kbFrame.height + 12
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
        //if (!keyboardShown) { return }
        //keyboardShown = false
        
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        //animation
        bottomOffset.constant = TAB_BAR_HEIGHT + 12
        UIView.animateWithDuration(duration)
        {
            self.view.layoutIfNeeded()
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
    
    
    /**
     * Called when user presses create button
     */
    @IBAction func createPressed(sender: AnyObject?)
    {
        
    }
    
    
    //MARK: TableView DataSource
    /**
    * - returns: number of sections will be 1 for this table
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    /**
     * - note: returns dummy value of 3 for now
     *
     * - returns: number of items current PFUser has
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (groups == nil) {
            return 0
        }
        return groups!.count
    }
    
    /**
     *
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)!
        cell.accessoryType = .None
        
        let index = indexPath.row
        let label = cell.viewWithTag(1) as! UILabel
        label.text = groups![index]["groupName"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if (cell.accessoryType == .None) {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        
        self.table.deselectRowAtIndexPath(indexPath, animated: true)
    }
}








