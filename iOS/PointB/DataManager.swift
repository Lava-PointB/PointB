//
//  DataManager.swift
//  PointB
//
//  Created by Kevin on 12/3/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager();
    
    private init() {}
    
    var items = [PFObject]()
    var groups = [PFObject]()
    
    // getUserItems
    // 
    // @param a completion handler that takes in the items and updates the tableview of the profile view controller
    //
    func getUserItems(completion: (items: [PFObject]?) -> Void)
    {
        PFCloud.callFunctionInBackground("getUserItems", withParameters: ["userId": PFUser.currentUser()!.objectId!])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getUserItems")
                    completion(items: nil)
                }
                
                var items: [PFObject]?
                
                if (object != nil)
                {
                    items = (object as! [PFObject])
                    self.items = items!
                }
                else
                {
                    items = nil
                }
                
                completion(items: items)
                
        }
    }
    
    // getUserGroups
    //
    // @param a completion handler that takes in the groups and updates the tableview of the profile view controller
    //
    func getUserGroups(completion: (groups: [PFObject]?) -> Void)
    {
        PFCloud.callFunctionInBackground("getUserGroups", withParameters: ["userId": PFUser.currentUser()!.objectId!])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getUserGroups")
                    completion(groups: nil)
                }
                
                var groups: [PFObject]?
                
                if (object != nil)
                {
                    groups = (object as! [PFObject])
                    self.groups = groups!
                }
                else
                {
                    groups = nil
                }
                
                completion(groups: groups)
                
        }
    }
    
    // getUserInfo
    //
    // @param a completion handler that takes in the user's info and updates the top of the profile view controller
    //
    func getUser(completion: (user: PFUser) -> Void)
    {
        PFCloud.callFunctionInBackground("getUserByUserId", withParameters: ["userId": PFUser.currentUser()!.objectId!])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getUserInfo")
                }
                
                var user: PFUser
                
                if (object != nil)
                {
                    user = object as! PFUser
                    completion(user: user)
                }
                
        }
    }
    
    
}