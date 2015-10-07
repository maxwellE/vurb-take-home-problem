//
//  MLEVurbMusicCardView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import UIKit

class MLEVurbMusicCardView: MLEVurbCardView {
    weak var openMusicVideoButton : MLEVurbOpenMusicVideoButton?
    
    override func setupTitleLabel() {
        super.setupTitleLabel()
        self.setupOpenMusicVideoButton()
    }
    
    override func titleLabelRightOffset() -> CGFloat {
        return -1 * MLEVurbOpenMusicVideoButton.buttonWidth
    }
    
    func setupOpenMusicVideoButton() {
        let openMusicVideoButton = MLEVurbOpenMusicVideoButton()
        openMusicVideoButton.addTarget(self, action: "openMusicVideo", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(openMusicVideoButton)
        self.openMusicVideoButton = openMusicVideoButton
        self.addConstraint(NSLayoutConstraint(item: openMusicVideoButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: openMusicVideoButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: openMusicVideoButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: openMusicVideoButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.titleView!, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:0))
    }
    
    func openMusicVideo() -> Void {
        if let musicVideoStringURL = self.cardData?.additionalData["musicVideoURL"] {
            if let musicVideoURL = NSURL(string: musicVideoStringURL) {
                UIApplication.sharedApplication().openURL(musicVideoURL)
            }
        }
    }
}
