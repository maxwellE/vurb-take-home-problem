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
        switch cardData.type {
        case .Movie:
            return MLEVurbMovieCardView(cardData: cardData)
        case .Music:
            return MLEVurbMusicCardView(cardData: cardData)
        case .Place:
            return MLEVurbPlaceCardView(cardData: cardData)
        default:
            return MLEVurbCardView(cardData: cardData)
        }
    }
}
