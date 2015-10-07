//
//  MLEVurbCardDataManager.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

class MLEVurbCardDataManager {
    var cardDataStore : Array<CardData> = Array<CardData>()
	
    class var sharedInstance: MLEVurbCardDataManager {
        struct Singleton {
            static let instance = MLEVurbCardDataManager()
        }
        return Singleton.instance
    }
    
    func loadCardDataFromResponseData(responseData : NSData) {
        self.cardDataStore = Array<CardData>()
        do {
            let responseDictionary = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
            let cardsData = responseDictionary["cards"] as! NSArray
            for rawCardData in cardsData {
                let cardInfo = rawCardData as! NSDictionary
                let cardData = CardData.init(cardInfo: cardInfo)
                self.cardDataStore.append(cardData)
            }
        } catch {
            // Handle parsing failure more gracefully!
            return
        }
    }
    
    func numberOfCards() -> Int {
        return cardDataStore.count
    }
	
    func cardDataForRow(row: Int) -> CardData? {
        return cardDataStore[row]
    }
}
