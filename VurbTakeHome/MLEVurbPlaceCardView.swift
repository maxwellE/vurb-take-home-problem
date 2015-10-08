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
        let averageImageColorOperation = NSBlockOperation { () -> Void in
            if let _ = self.cardData?.averageImageColor {
                return
            }
            if let thumbnailImage = downloadedImage {
                self.cardData?.averageImageColor = thumbnailImage.averageColor()
            }
        }
        let cropOperation = NSBlockOperation { [weak self] () -> Void in
            if let _ = self?.cardData!.croppedImage {
                return
            }
            if let thumbnailImage = downloadedImage {
                self?.cardData!.croppedImage = Toucan(image: thumbnailImage).resize(thumbnailImage.size, fitMode: Toucan.Resize.FitMode.Crop).image
            }
        }
        cropOperation.addDependency(averageImageColorOperation)
        operationQueue.addOperation(averageImageColorOperation)
        operationQueue.addOperation(cropOperation)
        cropOperation.completionBlock = ({ [weak self] () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self?.thumbnailImageView?.clipsToBounds = true
                self?.thumbnailImageView?.contentMode = UIViewContentMode.Center
                self?.thumbnailImageView?.image = self?.cardData!.croppedImage
                if let averageColorBackgroundColor = self?.cardData?.averageImageColor {
                    self?.backgroundColor = averageColorBackgroundColor
                }
            })
        })
    }
}
