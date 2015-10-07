//
//  MLEVurbCardContainerViewProtocol.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation

protocol MLEVurbCardContainerViewProtocol {
    weak var cardView: MLEVurbCardView? { get set }
    
    func removeCardView() -> Void
    
    func addCardView(cardView: MLEVurbCardView) -> Void
}
