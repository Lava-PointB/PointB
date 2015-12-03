//
//  ProfileVC.swift
//  PointB
//
//  Created by Bohui Moon on 11/12/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit


/**
 * ### ProfileVC
 *
 * `ProfileVC` presents the profile page using currently logged in `PFUser`'s data.
 */
class ProfileVC: UIViewController, UITableViewDataSource
{
    //MARK: Constants
    private let HEIGHT_RATIO: CGFloat = 0.4
    private let FONT_RATIO: CGFloat = 0.067

    private let CELL_ID = "ProfileItemCell"

    private var userItems: [PFObject]? = nil

    //MARK: IBOutlets
    //header
    @IBOutlet var header: UIView!
    @IBOutlet var headerHeight: NSLayoutConstraint!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileOffset: NSLayoutConstraint!
    
    @IBOutlet var atLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var groupsLabel: UILabel!
    @IBOutlet var ideasLabel: UILabel!
    @IBOutlet var completedLabel: UILabel!
    
    //table
    @IBOutlet var tableView: UITableView!


    //MARK: Init
    /**
     * Called immediately after view loads its content (but before layout).
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Profile", style: .Plain, target: nil, action: nil)
        
        //request bucket items from a DataManager with callback to update tableview once done
        DataManager.sharedInstance.getUserItems()
            { (items: [PFObject]?) in
                self.updateTableView(items);
        }
    }
    
    /**
     *
     */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        adjustUI()
    }
    
    
    //Mark: UIControl
    /**
     * Adjust the UI based on screen size
     */
    func adjustUI()
    {
        let width = SCREEN_SIZE.width
        let font = atLabel.font.fontWithSize(width * FONT_RATIO)
        
        //initial height adjustment
        headerHeight.constant = width * HEIGHT_RATIO
        usernameLabel.font = font
        atLabel.font = font
        view.layoutIfNeeded()
        
        //subsequent
        profileImageView.cornerRadius = profileImageView.height/2
        
        
//        if (SCREEN_SIZE.width > WIDTH_LARGE)
//        {
//            profileOffset.constant = 40;
//        }
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
        if (userItems == nil)
        {
            return 0
        }
        else
        {
            return userItems!.count
        }
    }
    
    /**
     *
     * - returns:
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //get cell
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) as! ProfileItemCell
        
        let item = userItems![indexPath.row]
        
        //configure
        cell.nameLabel.text = item["title"] as! String?
        
        
        let createdOn: NSDate = item.createdAt!
        let today: NSDate = NSDate()
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: createdOn, toDate: today, options: [])
        
        let daysDif:Int = components.day
        
        var timeText:String
        
        if (components.minute < 1)
        {
            timeText = "Just now"
        }
        else if (components.hour < 1)
        {
            if (components.minute == 1)
            {
                timeText = "A minute ago"
            }
            else
            {
                timeText = "\(components.minute) minutes ago"
            }
        }
        else if (components.day < 1)
        {
            if (components.hour == 1)
            {
                timeText = "An hour ago"
            }
            else
            {
                timeText = "\(components.hour) hours ago"
            }
        }
        else if (components.day < 7)
        {
            if (components.day == 1)
            {
                timeText = "A day ago"
            }
            else
            {
                timeText = "\(components.day) days ago"
            }
        }
        else if (components.month < 1)
        {
            if (components.day/7 == 1)
            {
                timeText = "A week ago"
            }
            else
            {
                timeText = "\(components.day/7) week ago"
            }
        }
        else if (components.year < 1)
        {
            if (components.month == 1)
            {
                timeText = "A month ago"
            }
            else
            {
                timeText = "\(components.month) months ago"
            }
        }
        else
        {
            if (components.year == 1)
            {
                timeText = "A year ago"
            }
            else
            {
                timeText = "\(components.year) minutes ago"
            }
        }
        
        
        cell.timeLabel.text = timeText
        return cell
    }
    
    func updateTableView(items: [PFObject]?) {
        userItems = items
        self.tableView.reloadData()
    }
}






