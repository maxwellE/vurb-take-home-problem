//
//  MLEVurbNetworkingManager.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import AFNetworking

class MLEVurbNetworkingManager {
    let sessionManager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let cardDataUrlString : String = "https://gist.githubusercontent.com/maxwellE/d3ee6b4e02fdf937e7fe/raw/94125005c03413503009d31ad51993a8e4a67a98/vurbtakehome.json"
	
    class var sharedInstance: MLEVurbNetworkingManager {
        struct Singleton {
            static let instance = MLEVurbNetworkingManager()
        }
        return Singleton.instance
    }
    
    func getCardData(successBlock: () -> Void, failureBlock: (error: NSError?) -> Void) {
        let responseSerializer = AFHTTPResponseSerializer()
        responseSerializer.acceptableContentTypes = Set.init(arrayLiteral: "text/plain")
        self.sessionManager.responseSerializer = responseSerializer
        self.sessionManager.GET(cardDataUrlString, parameters: nil, success: { (operation, responseData) -> Void in
                MLEVurbCardDataManager.sharedInstance.loadCardDataFromResponseData(responseData as! NSData)
                successBlock()
            }) { (operation, error) -> Void in
                failureBlock(error: error)
        }
    }
}
