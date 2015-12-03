//
//  MainTBC.swift
//  PointB
//
//  Created by Kevin on 10/26/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 * ### class - MainTBC
 *
 */
class MainTBC: UITabBarController, UITabBarControllerDelegate
{
    //MARK: constants
    let itemWidth = SCREEN_SIZE.width / 5

    //MARK: ivars
    let createButton = UIButton()
    let indicator = UIView()
    let overlay = UIView()
    
    var setup = true
    
    
    
    //MARK: - Init
    /**
     * Called when view has been loaded, but not yet shown.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.delegate = self
    }
    
    /**
     * Called when the view is about to appear and AutoLayout has been applied.
     */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        //first time
        if (setup)
        {
            configureTabBar()
        
            overlay.backgroundColor = UIColor(white: 0.f, alpha: 0.25.f)
            overlay.frame = view.frame
            overlay.hidden = true
            view.addSubview(overlay)
            
            setup = false;
        }
    }
    
    
    /**
     * Configure the TabBar UI and add any necessary elements
     */
    func configureTabBar()
    {
        //basic ui
        tabBar.clipsToBounds = false
        tabBar.barStyle = UIBarStyle.BlackOpaque
        tabBar.backgroundColor = UIColor(white: 1.f, alpha: 1.f)
        
    
        //indicator bar
        let topHeight = 5.f
        let top = UIView(frame: CGRectMake(0, -topHeight, tabBar.width, topHeight))
        top.backgroundColor = UIColor.blackColor()
        
        indicator.frame = CGRectMake(0, 0, itemWidth, topHeight)
        indicator.backgroundColor = UIColor(red: 239/255.f, green: 87/255.f, blue: 76/255.f, alpha: 1.f)
        top.addSubview(indicator)
        tabBar.addSubview(top)
        
    
        //items
        let items = tabBar.items!
        for (var i=0; i < items.count; i++)
        {
            let item = items[i]
            let image = UIImage(named: "tab-icon-\(i+1)")
            item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
            item.image = image?.imageWithRenderingMode(.AlwaysOriginal)
            item.selectedImage = image?.imageWithRenderingMode(.AlwaysOriginal)
        }
        
        //create button
        createButton.frame = CGRectMake(tabBar.width/2 - itemWidth/2, -topHeight, itemWidth, topHeight + tabBar.height)
        createButton.setImage(UIImage(named: "tab-icon-3"), forState: .Normal)
        createButton.backgroundColor = COLOR_GREEN
        createButton.addTarget(self, action: Selector("createPressed"), forControlEvents: .TouchUpInside)
        tabBar.addSubview(createButton)
    }
    
    
    //MARK:
    
    
    
    //MARK: Delegates
    /**
     * 
     */
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem)
    {
        let index = tabBar.items!.indexOf(item)!
        
        UIView.animateWithDuration(0.3)
        {
            self.indicator.x = self.itemWidth * index.f
        }
    }
    
    /**
     *
     */
    func createPressed()
    {
        overlay.hidden = false
        performSegueWithIdentifier("CreateSegue", sender: self)
        self.view.userInteractionEnabled = true
    }
    
    
    //MARK: Navigation
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?)
    {
        super.dismissViewControllerAnimated(flag)
        {
            self.overlay.hidden = true
        }
    }
}






