//
//  MLEVurbMovieCardView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation

class MLEVurbMovieCardView: MLEVurbCardView {
    override func thumbnailImageURL() -> NSURL {
        return NSURL(string: self.cardData!.additionalData["movieExtraImageURL"]!)!
    }
}
