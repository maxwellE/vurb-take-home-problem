//
//  MLEVurbCardListTableViewCell.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/7/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

// Rename
class MLEVurbCardListTableViewCell: UITableViewCell {
    weak var cardView : MLEVurbCardView?
    
    func commonInit() {
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: MLEVurbCardListTableViewController.reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
    }
    
    // MARK: MLEVurbCardContainerViewProtocol methods
    
    func addCardView(cardView: MLEVurbCardView) {
        self.addSubview(cardView)
        self.cardView = cardView
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.95, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.8, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: cardView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        cardView.setupCardView()
    }
    
    func removeCardView() {
        self.cardView?.removeFromSuperview()
        self.cardView = nil
    }
    
    override func prepareForReuse() {
        self.removeCardView()
    }

}
