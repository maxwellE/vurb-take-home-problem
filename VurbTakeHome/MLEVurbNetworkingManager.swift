//
//  MLEVurbNetworkingManager.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

class MLEVurbNetworkingManager {
    let sessionManager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let cardDataUrlString : String = "https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.json"
	
    class var sharedInstance: MLEVurbNetworkingManager {
        struct Singleton {
            static let instance = MLEVurbNetworkingManager()
        }
        return Singleton.instance
    }
    
    func getCardData(successBlock: (responseDictionary: NSDictionary) -> Void, failureBlock: (error: NSError?) -> Void) {
        let responseSerializer = AFHTTPResponseSerializer()
        responseSerializer.acceptableContentTypes = Set.init(arrayLiteral: "text/plain")
        self.sessionManager.responseSerializer = responseSerializer
        self.sessionManager.GET(cardDataUrlString, parameters: nil, success: { (operation, responseData) -> Void in
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(responseData as! NSData, options: NSJSONReadingOptions.AllowFragments)
                successBlock(responseDictionary: jsonData as! NSDictionary)
            } catch {
                failureBlock(error: nil)
            }
            }) { (operation, error) -> Void in
                failureBlock(error: error)
        }
    }
}
