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
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(5,5)
        self.layer.shadowOpacity = 0.5
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
        self.backgroundColor = self.viewBackgroundColor()
        self.setupThumbnailImageView()
        self.setupTitleLabel()
    }
    
    override func layoutSubviews() {
        if let thumbnailImageView = self.thumbnailImageView {
            self.setupThumbnailImageViewImageDownloader(thumbnailImageView)
        }
    }
    
    func viewBackgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    // MARK: View setup helpers
    
    // MARK: Title View Logic
    
    func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.cardData!.title
        self.addSubview(titleLabel)
        self.titleView = titleLabel
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.thumbnailImageView!, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: self.titleLabelRightOffset()))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
    
    // This method can be overriden to provide a custom right label offset value
    func titleLabelRightOffset() -> CGFloat {
        return 0
    }
    
    // MARK: Thumbnail ImageView Logic
    
    func setupThumbnailImageView() {
        let thumbnailImageView = UIImageView()
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thumbnailImageView)
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.thumbnailImageView = thumbnailImageView
    }
    
    
    // This method can be overriden
    func thumbnailImageURL() -> NSURL {
        return NSURL(string: self.cardData!.thumbnailImageURLString)!
    }
    
    func setupThumbnailImageViewImageDownloader(thumbnailImageView: UIImageView) {
        thumbnailImageView.sd_setImageWithURL(self.thumbnailImageURL())
    }
}
