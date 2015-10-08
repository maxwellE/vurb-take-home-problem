//
//  MLEVurbOpenMusicVideoButton.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbOpenMusicVideoButton: UIButton {
    static let buttonWidth : CGFloat = 60
    
    func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Play", forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    init() {
        super.init(frame: CGRectZero)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
