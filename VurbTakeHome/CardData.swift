//
//  CardData.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

// Setup CardType Enum

import Foundation
import UIKit



class CardData: NSObject {
    var type : CardType = CardType.None
    var typeString : String = ""
    var title : String = ""
    var thumbnailImageURLString : String = ""
    var additionalData : Dictionary<String, String> = Dictionary<String, String>()
    let mandatoryCardInfoKeys = ["type", "title", "imageURL"]
    
    convenience init(cardInfo: NSDictionary) {
        self.init()
        typeString = cardInfo["type"] as! String
        self.determineCardType(typeString)
        title = cardInfo["title"] as! String
        thumbnailImageURLString = cardInfo["imageURL"] as! String
        for (key, value) in cardInfo {
            if (!self.mandatoryCardInfoKeys.contains(key as! String)) {
                additionalData[key as! String] = (value as! String)
            }
        }
    }
    
    func determineCardType(cardTypeString: String) {
        switch cardTypeString {
            case "place":
                self.type = CardType.Place
            case "movie":
                self.type = CardType.Movie
            case "music":
                self.type = CardType.Music
            default:
                self.type = CardType.None
        }
    }
}
