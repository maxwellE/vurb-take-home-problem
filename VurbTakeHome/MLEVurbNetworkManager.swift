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
    var cardDataUrlString : String = "https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.js"
    var dataManager : MLEVurbCardDataManager?
    
    init() {
    }
    
    convenience init(dataManager: MLEVurbCardDataManager) {
        self.init()
        self.dataManager = dataManager
    }
    
    func getCardData(successBlock: () -> Void, failureBlock: (error: NSError?) -> Void) {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.timeoutIntervalForRequest = 2
        let sessionManager = AFHTTPSessionManager(sessionConfiguration: sessionConfiguration)
        let responseSerializer = AFHTTPResponseSerializer()
        responseSerializer.acceptableContentTypes = Set.init(arrayLiteral: "text/plain")
        sessionManager.responseSerializer = responseSerializer
        sessionManager.GET(cardDataUrlString, parameters: nil, success: { [weak self] (operation, responseData) -> Void in
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