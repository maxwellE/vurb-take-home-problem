//
//  CardData.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

class CardData: NSObject {
    var typeString : String = ""
    var title : String = ""
    var imageURLString : String = ""
    var additionalData : Dictionary<String, String> = Dictionary<String, String>()
    let mandatoryCardInfoKeys = ["type", "title", "imageURL"]
    
    convenience init(cardInfo: NSDictionary) {
        self.init()
        typeString = cardInfo["type"] as! String
        title = cardInfo["title"] as! String
        imageURLString = cardInfo["imageURL"] as! String
        for (key, value) in cardInfo {
            if (!self.mandatoryCardInfoKeys.contains(key as! String)) {
                additionalData[key as! String] = (value as! String)
            }
        }
    }
}
