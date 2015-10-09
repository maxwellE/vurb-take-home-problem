//
//  MLEVurbNetworkManager.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/8/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import AFNetworking

class MLEVurbNetworkManager {
    var cardDataUrlString : String = "https://gist.githubusercontent.com/maxwellE/d3ee6b4e02fdf937e7fe/raw/94125005c03413503009d31ad51993a8e4a67a98/vurbtakehome.json"
    var sessionManager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    var dataManager : MLEVurbCardDataManager?
    
    init() {
    }
    
    convenience init(dataManager: MLEVurbCardDataManager) {
        self.init()
        self.dataManager = dataManager
    }
    
    func getCardData(successBlock: () -> Void, failureBlock: (error: NSError?) -> Void) {
        let responseSerializer = AFHTTPResponseSerializer()
        responseSerializer.acceptableContentTypes = Set.init(arrayLiteral: "text/plain")
        self.sessionManager.responseSerializer = responseSerializer
        self.sessionManager.GET(cardDataUrlString, parameters: nil, success: { [weak self] (operation, responseData) -> Void in
            self?.dataManager?.loadCardDataFromResponseData(responseData as! NSData)
            successBlock()
            }) { (operation, error) -> Void in
                failureBlock(error: error)
        }
    }
    
    deinit {
        self.dataManager = nil
    }
}