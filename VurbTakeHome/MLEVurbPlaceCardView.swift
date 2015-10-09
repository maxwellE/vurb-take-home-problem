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
    
    override func setupThumbnailImageViewImageDownloader(thumbnailImageView: UIImageView) {
        let operationQueue = NSOperationQueue()
        let downloadImageOperation = NSBlockOperation { [weak self] () -> Void in
            if (self?.cardData?.croppedImage != nil) {
                return
            }
            if (self?.cardData?.imageToBeCropped != nil) {
                return
            }
            if let imageData = NSData(contentsOfURL: (self?.thumbnailImageURL())!) {
                self?.cardData?.imageToBeCropped = UIImage(data: imageData)
            }
        }
        let averageImageColorOperation = NSBlockOperation { [weak self] () -> Void in
            if (self?.cardData?.averageImageColor != nil) {
                return
            }
            if let thumbnailImage = self?.cardData?.imageToBeCropped {
                self?.cardData?.averageImageColor = thumbnailImage.averageColor()
            }
        }
        let cropOperation = NSBlockOperation { [weak self] () -> Void in
            if (self?.cardData!.croppedImage != nil) {
                return
            }
            if let thumbnailImage = self?.cardData?.imageToBeCropped {
                if let thumbnailImageView = self?.thumbnailImageView {
                    self?.cardData!.croppedImage = Toucan(image: thumbnailImage).resize(thumbnailImageView.bounds.size, fitMode: Toucan.Resize.FitMode.Crop).image
                    
                }
            }
        }
        // More comments
        let completionOperation = NSBlockOperation { [weak self] () -> Void in
            self?.cardData?.imageToBeCropped = nil
            self?.imageOperationsCompleteBlock()
        }
        averageImageColorOperation.addDependency(downloadImageOperation)
        cropOperation.addDependency(downloadImageOperation)
        completionOperation.addDependency(averageImageColorOperation)
        completionOperation.addDependency(cropOperation)
        operationQueue.addOperations([downloadImageOperation, averageImageColorOperation, cropOperation, completionOperation], waitUntilFinished: false)
    }
    
    func imageOperationsCompleteBlock() {
        dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
            if let averageColorBackgroundColor = self?.cardData?.averageImageColor {
                if let croppedImage = self?.cardData?.croppedImage {
                    self?.backgroundColor = averageColorBackgroundColor
                    self?.thumbnailImageView?.contentMode = UIViewContentMode.Center
                    self?.thumbnailImageView?.image = croppedImage
                }
            }
        })
    }
}
