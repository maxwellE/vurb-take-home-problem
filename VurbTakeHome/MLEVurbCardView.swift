//
//  MLEVurbCardView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit
import SDWebImage

class MLEVurbCardView: UIView {
    var cardData : CardData?
    weak var titleView : UILabel?
    weak var thumbnailImageView : UIImageView?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init() {
        super.init(frame: CGRectZero)
        self.commonInit()
    }
    
    
    convenience init(cardData: CardData) {
        self.init()
        self.cardData = cardData
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // MARK: View Management
    
    func setupCardView() {
        self.setupThumbnailImageView()
        self.setupTitle()
    }
    
    // MARK: View setup helpers

    func setupThumbnailImageView() {
        let thumbnailImageView = UIImageView()
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.backgroundColor = UIColor.blueColor()
        self.setupThumbnailImageViewImageDownloader(thumbnailImageView)
        self.addSubview(thumbnailImageView)
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.thumbnailImageView = thumbnailImageView
    }
    
    func setupTitle() {
        
    }
    
    func setupThumbnailImageViewImageDownloader(thumbnailImageView: UIImageView) {
        thumbnailImageView.sd_setImageWithURL(NSURL(string: self.cardData!.thumbnailImageURLString())!) { [weak self] (downloadedImage, error, imageCacheType, imageURL) -> Void in
            self?.thumbnailImageDidCompleteDownload(downloadedImage, error: error, imageCacheType: imageCacheType, imageURL: imageURL)
        }
    }
    
    func thumbnailImageDidCompleteDownload(downloadedImage: UIImage?, error: NSError?, imageCacheType: SDImageCacheType, imageURL: NSURL) {
        // This base class does nothing for this method
    }
}
