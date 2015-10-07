//
//  MLEVurbNetworkingManager.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

class MLEVurbNetworkingManager {
	
    class var sharedInstance: MLEVurbNetworkingManager {
        struct Singleton {
            static let instance = MLEVurbNetworkingManager()
        }
        return Singleton.instance
    }
    
    func getCardData(cardDataUrlString: String) {
        
    }
}
