//
//  SettingsTVC.swift
//  PointB
//
//  Created by Bohui Moon on 11/16/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 *
 */
class SettingsTVC: UITableViewController
{
    @IBOutlet var logoutCell: UITableViewCell!


    //MARK: - Init
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    /**
     * Called when user presses a cell.
     * Depending on the indexPath of the selection, perform actions accordingly.
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let section = indexPath.section
        let index = indexPath.row
        
        if (section == 1 && index == 0) //logout
        {
            logoutCheck(indexPath)
        }
    }
    
    
    /**
     * Called when user selects the Logout row.
     * Confirm that user actually wants to logout using UIAlertController and perform action accordingly.
     */
    func logoutCheck(indexPath: NSIndexPath)
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //logout confirmed, dimiss parent TabBarController
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.Destructive)
        { (action: UIAlertAction) -> Void in
            //logout
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            alert.dismissViewControllerAnimated(true, completion: nil)
            
            PFUser.logOut()
            self.tabBarController?.dismissViewControllerAnimated(true, completion: nil)
        })
        
        //canceled
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
        { (action: UIAlertAction) -> Void in
            //dont do anything
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            alert.dismissViewControllerAnimated(true, completion: nil)
        })
        
        //
        presentViewController(alert, animated: true, completion: nil)
    }
}
