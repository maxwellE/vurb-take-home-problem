//
//  MLECardNetworkFetchFailureView.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/9/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLECardNetworkFetchFailureView: UIView {
    var errorText : String = "Could not contact card data overlords"
    weak var errorLabel : UILabel?

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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    convenience init(errorText: String) {
        self.init()
        self.errorText = errorText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let errorLabel = self.errorLabel {
            errorLabel.text = self.errorText
            return
        }
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = self.errorText
        errorLabel.textAlignment = .Center
        self.addSubview(errorLabel)
        self.addConstraint(NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.3, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: errorLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        self.errorLabel = errorLabel
    }

}
