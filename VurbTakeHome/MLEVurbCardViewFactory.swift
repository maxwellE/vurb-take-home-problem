//
//  MLEVurbCardViewFactory.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbCardViewFactory {
	
    class var sharedInstance: MLEVurbCardViewFactory {
        struct Singleton {
            static let instance = MLEVurbCardViewFactory()
        }
        return Singleton.instance
    }
	
    func generateCardViewInsideParentView(cardData: CardData, parentView: UIView) {
        let cardView = MLEVurbCardView(cardData: cardData)
        parentView.addSubview(cardView)
        cardView.setupCardView()
        parentView.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: parentView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        parentView.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: parentView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        parentView.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: parentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        parentView.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: parentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
}
