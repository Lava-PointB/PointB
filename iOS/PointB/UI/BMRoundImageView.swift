//
//  BMRoundImageView.swift
//  PointB
//
//  Created by Bohui Moon on 11/13/15.
//  Copyright © 2015 Lava-PointB. All rights reserved.
//

import UIKit

/**
 * ### Class - BMRoundImageView
 *
 *
 */
@IBDesignable
class BMRoundImageView: UIImageView
{
    override var frame: CGRect
    {
        didSet {
            self.cornerRadius = self.height/2;
        }
    }
}
