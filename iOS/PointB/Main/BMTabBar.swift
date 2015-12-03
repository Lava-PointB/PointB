//
//  BMTabBar.swift
//  PointB
//
//  Created by Bohui Moon on 12/3/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

class BMTabBar: UITabBar
{

    override func sizeThatFits(size: CGSize) -> CGSize
    {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = TAB_BAR_HEIGHT
        
        return sizeThatFits
    }
}
