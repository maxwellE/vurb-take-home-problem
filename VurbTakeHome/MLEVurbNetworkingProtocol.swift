//
//  MLEVurbNetworkingProtocol.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/8/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import AFNetworking

protocol MLEVurbNetworkingProtocol {
    var cardDataUrlString: String { get set }
    var sessionManager : AFHTTPRequestOperationManager { get }
    var dataManager : MLEVurbCardDataProtocol? { get }
    
    func getCardData(successBlock: () -> Void, failureBlock: (error: NSError?) -> Void) -> Void
}
