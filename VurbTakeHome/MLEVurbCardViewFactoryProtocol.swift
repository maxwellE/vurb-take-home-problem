//
//  MLEVurbCardViewFactoryProtocol.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/8/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation

protocol  MLEVurbCardViewFactoryProtocol {
    func generateCardView(cardData : CardData) -> MLEVurbCardView
}