//
//  MLEVurbPlaceCardView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbPlaceCardView: MLEVurbCardView {
    
    override func viewBackgroundColor() -> UIColor {
        if let averageImageColor = self.cardData?.thumbnailImageData.averageImageColor {
            return averageImageColor
        }
        return UIColor.whiteColor()
    }
    
    // Handles Place's card advanced image downloading and concurrent actions
    override func setupThumbnailImageViewImageDownloader(thumbnailImageView: UIImageView) {
        let operationQueue = NSOperationQueue()
        // Our first NSOperation downloads the image and saves it to the thumbnailImageData object for later operations
        let downloadImageOperation = NSBlockOperation { [weak self] () -> Void in
            // If there is a cropped image there is nothing to do
            if (self?.cardData?.thumbnailImageData.croppedImage != nil) {
                return
            }
            // If we already downloaded the image there is nothing to do
            if (self?.cardData?.thumbnailImageData.image != nil) {
                return
            }
            // Synchronously get the image data and save the image to thumbnailImageData
            if let imageData = NSData(contentsOfURL: (self?.thumbnailImageURL())!) {
                let imageToBeCropped = UIImage(data: imageData)
                self?.cardData?.thumbnailImageData.image = imageToBeCropped
            }
        }
        // Next we need to compute the average color and crop the image at the same time
        // These next 2 NSOperations complete these tasks. Both of these tasks depend on
        // the downloadImageOperation so they cannot start until it is finished
        let averageImageColorOperation = NSBlockOperation { [weak self] () -> Void in
            // Return if we already computed the averageImageColor
            if (self?.cardData?.thumbnailImageData.averageImageColor != nil) {
                return
            }
            // Compute average color and save it to thumbnailImageData
            if let thumbnailImage = self?.cardData?.thumbnailImageData.image {
                self?.cardData?.thumbnailImageData.averageImageColor = thumbnailImage.averageColor()
            }
        }
        let cropOperation = NSBlockOperation { [weak self] () -> Void in
            // We already have the croppedImage, return
            if (self?.cardData?.thumbnailImageData.croppedImage != nil) {
                return
            }
            if let thumbnailImage = self?.cardData?.thumbnailImageData.image {
                if let thumbnailImageView = self?.thumbnailImageView {
                    // Crop the image and save it to thumbnailImageData
                    thumbnailImageView.setNeedsLayout()
                    thumbnailImageView.layoutIfNeeded()
                    self?.cardData?.thumbnailImageData.croppedImage = Toucan(image: thumbnailImage).resize(thumbnailImageView.bounds.size, fitMode: Toucan.Resize.FitMode.Crop).image
                    
                }
            }
        }
        // This final operation depends on the rest of the operations, so it is only fired after they all complete
        let completionOperation = NSBlockOperation { [weak self] () -> Void in
            // Clear out imageToBeCropped now, it is no longer of use
            self?.imageOperationsCompleteBlock()
        }
        // averageImageColorOperation and cropOperation depend on the downloadImageOperation to function
        averageImageColorOperation.addDependency(downloadImageOperation)
        cropOperation.addDependency(downloadImageOperation)
        // completionOperation depends on the completion of averageImageColorOperation and cropOperation
        completionOperation.addDependency(averageImageColorOperation)
        completionOperation.addDependency(cropOperation)
        operationQueue.addOperations([downloadImageOperation, averageImageColorOperation, cropOperation, completionOperation], waitUntilFinished: false)
    }
    
    func imageOperationsCompleteBlock() {
        dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
            if let averageColorBackgroundColor = self?.cardData?.thumbnailImageData.averageImageColor {
                if let croppedImage = self?.cardData?.thumbnailImageData.croppedImage {
                    // Set the correct values on UI elements on the main thread
                    self?.backgroundColor = averageColorBackgroundColor
                    self?.thumbnailImageView?.contentMode = UIViewContentMode.Center
                    self?.thumbnailImageView?.image = croppedImage
                }
            }
        })
    }
}
