//
//  ProfileItemCell.swift
//  PointB
//
//  Created by Bohui Moon on 11/15/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 *
 */
class ProfileItemCell: UITableViewCell
{

    //MARK: Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!

    @IBOutlet var actionButton: UIButton!


    //MARK: - Init
    /**
     *
     */
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    /**
     *
     */
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
    }


    //MARK: Actions
    /**
     * Called when user presses the action button (right arrow)
     */
    @IBAction func actionPressed(sender: AnyObject?)
    {
        
    }
}
