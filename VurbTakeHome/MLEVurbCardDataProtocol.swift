//
//  MLEVurbCardDataProtocol.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/8/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation

protocol MLEVurbCardDataProtocol {
    var cardDataStore : Array<CardData> { get }
    
    func loadCardDataFromResponseData(responseData : NSData) -> Void
    
    func numberOfCards() -> Int
    
    func cardDataForRow(row: Int) -> CardData?
}