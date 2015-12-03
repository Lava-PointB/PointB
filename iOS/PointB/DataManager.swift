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
                }
                else
                {
                    items = nil;
                }
                
                completion(items: items);
                
        }
    }
    
    
}