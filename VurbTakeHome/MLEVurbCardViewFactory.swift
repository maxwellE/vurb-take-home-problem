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
	
    func generateCardView(cardData: CardData) -> MLEVurbCardView {
        let cardView = MLEVurbCardView(cardData: cardData)
        return cardView
    }
}
