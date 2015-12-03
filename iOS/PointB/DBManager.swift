//
//  DBManager.swift
//  PointB
//
//  Created by Kevin on 12/3/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//
//  All the implementation of the functions from Parse's Cloud Code
//  Check Cloud Code for comments for what each function does.
//
//  IMPORTANT!!!
//  Since functions are asynchronous, you can't specifically use these functions
//  This class is mostly for tempalte for the functions already written (Mostly because I thought differently earlier)
//

import Foundation

class DBManager {
    
    static func createItem(title: String) -> (PFObject?) {
        
        var item: PFObject?
        
        PFCloud.callFunctionInBackground("createItem", withParameters: ["title": title])
        { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: createItem")
                    return
                }
                
                if (object != nil)
                {
                    item = (object as! PFObject)
                }
                else
                {
                    item = nil;
                }

        }
        return item
    }
    
    static func addItemToUser(itemId: String, userId: String) -> (PFObject?){
        
        var user: PFObject?
        
        PFCloud.callFunctionInBackground("addItemToUser", withParameters: ["itemId": itemId, "userId": userId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: addItemToUser")
                    return
                }
                
                if (object != nil)
                {
                    user = (object as! PFObject)
                }
                else
                {
                    user = nil;
                }
                
        }
        
        return user
    }
    
    static func addItemToGroup(itemId: String, groupId: String) -> (PFObject?){
        
        var group: PFObject?
        
        PFCloud.callFunctionInBackground("addItemToGroup", withParameters: ["itemId": itemId, "groupId": groupId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: addItemToGroup")
                    return
                }
                
                if (object != nil)
                {
                    group = (object as! PFObject)
                }
                else
                {
                    group = nil;
                }
                
        }
        
        return group
    }
    
    static func createGroup(groupName: String) -> (PFObject?){
        
        var group: PFObject?
        
        PFCloud.callFunctionInBackground("createGroup", withParameters: ["groupName": groupName])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: createGroup")
                    return
                }
                
                if (object != nil)
                {
                    group = (object as! PFObject)
                }
                else
                {
                    group = nil;
                }
                
        }
        
        return group
    }
    
    static func addUserToGroup(userId: String, groupId: String) -> (PFObject?){
        
        var user: PFObject?
        
        PFCloud.callFunctionInBackground("addUserToGroup", withParameters: ["userId": userId, "groupId": groupId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: addUserToGroup")
                    return
                }
                
                if (object != nil)
                {
                    user = (object as! PFObject)
                }
                else
                {
                    user = nil;
                }
                
        }
        
        return user
    }
    
    static func getUserGroups(userId: String) -> ([PFObject]?) {
        
        var groups: [PFObject]?
        
        PFCloud.callFunctionInBackground("getUserGroups", withParameters: ["userId": userId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getUserGroups")
                    return
                }
                
                if (object != nil)
                {
                    groups = (object as! [PFObject])
                }
                else
                {
                    groups = nil;
                }
                
        }
        
        return groups
    }
    
    static func getUserItems(userId: String) -> ([PFObject]?) {
        
        var items: [PFObject]?
        
        PFCloud.callFunctionInBackground("getUserItems", withParameters: ["userId": userId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getUserItems")
                    return
                }
                
                if (object != nil)
                {
                    items = (object as! [PFObject])
                }
                else
                {
                    items = nil;
                }
                
        }
        
        return items
    }
    
    static func getGroupItems(groupId: String) -> ([PFObject]?) {
        
        var items: [PFObject]?
        
        PFCloud.callFunctionInBackground("getGroupItems", withParameters: ["groupId": groupId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getGroupItems")
                    return
                }
                
                if (object != nil)
                {
                    items = (object as! [PFObject])
                }
                else
                {
                    items = nil;
                }
                
        }
        
        return items
    }
    
    static func getGroupUsers(groupId: String) -> ([PFObject]?) {
        
        var users: [PFObject]?
        
        PFCloud.callFunctionInBackground("getGroupUsers", withParameters: ["groupId": groupId])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getGroupUsers")
                    return
                }
                
                if (object != nil)
                {
                    users = (object as! [PFObject])
                }
                else
                {
                    users = nil;
                }
                
        }
        
        return users
    }
    
    static func getGroupByGroupName(groupName: String) -> (PFObject?) {
        
        var group: PFObject?
        
        PFCloud.callFunctionInBackground("getGroupByGroupName", withParameters: ["groupName": groupName])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: getGroupItems")
                    return
                }
                
                if (object != nil)
                {
                    group = (object as! PFObject)
                }
                else
                {
                    group = nil;
                }
                
        }
        
        return group
    }
    
    static func searchGroups(searchText: String) -> ([PFObject]?) {
        var groups: [PFObject]?
        
        PFCloud.callFunctionInBackground("searchGroups", withParameters: ["searchText": searchText])
            { (object: AnyObject?, error: NSError?) in
                if (error != nil)
                {
                    print("[Error] PFCloud: searchGroups")
                    return
                }
                
                if (object != nil)
                {
                    groups = (object as! [PFObject])
                }
                else
                {
                    groups = nil
                }
        }
        
        return groups
    }
}