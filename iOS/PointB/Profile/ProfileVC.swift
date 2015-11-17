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
        return 3
    }
    
    /**
     *
     * - returns:
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //get cell
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) as! ProfileItemCell
        
        //configure
        cell.nameLabel.text = "Skydiving over LA!"
    
        return cell
    }
}






