//
//  MLEVurbPlaceCardView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit
import SDWebImage

class MLEVurbPlaceCardView: MLEVurbCardView {
    
    override func viewBackgroundColor() -> UIColor {
        if let averageImageColor = self.cardData?.averageImageColor {
            return averageImageColor
        }
        return UIColor.whiteColor()
    }
    
    override func thumbnailImageDidCompleteDownload(downloadedImage: UIImage?, error: NSError?, imageCacheType: SDImageCacheType, imageURL: NSURL) {
        let operationQueue = NSOperationQueue()
        let averageImageColorOperation = NSBlockOperation { [weak self] () -> Void in
            if let _ = self?.cardData?.averageImageColor {
                return
            }
            if let thumbnailImage = downloadedImage {
                self?.cardData?.averageImageColor = thumbnailImage.averageColor()
            }
        }
        let cropOperation = NSBlockOperation { [weak self] () -> Void in
            if let _ = self?.cardData!.croppedImage {
                return
            }
            if let thumbnailImage = downloadedImage {
                if let thumbnailImageView = self?.thumbnailImageView {
                   thumbnailImageView.layoutIfNeeded()
                    self?.cardData!.croppedImage = Toucan(image: thumbnailImage).resize(thumbnailImageView.bounds.size, fitMode: Toucan.Resize.FitMode.Crop).image

                }
            }
        }
        let completionOperation = NSBlockOperation { [weak self] () -> Void in
            self?.imageOperationsCompleteBlock()
        }
        completionOperation.addDependency(averageImageColorOperation)
        completionOperation.addDependency(cropOperation)
        operationQueue.addOperations([averageImageColorOperation, cropOperation, completionOperation], waitUntilFinished: false)
    }
    
    func imageOperationsCompleteBlock() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let averageColorBackgroundColor = self.cardData?.averageImageColor {
                if let croppedImage = self.cardData?.croppedImage {
                    self.backgroundColor = averageColorBackgroundColor
                    self.thumbnailImageView?.contentMode = UIViewContentMode.Center
                    self.thumbnailImageView?.image = croppedImage
                }
            }
        })
    }
}
