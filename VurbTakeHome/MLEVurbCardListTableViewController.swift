//
//  MLEVurbCardListTableViewController.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbCardListTableViewController: UITableViewController {
    static let reuseIdentifier = "CardCell"
    var cardDataArray : Array<String> = Array<String>()
    var networkingManager : MLEVurbNetworkManager?
    var cardDataManager : MLEVurbCardDataManager?
    weak var networkFetchErrorView : MLECardNetworkFetchFailureView?
    
    // MARK: Initializers
    
    func commonInit() {
        self.tableView.registerClass(MLEVurbCardListTableViewCell.classForCoder(), forCellReuseIdentifier: MLEVurbCardListTableViewController.reuseIdentifier)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor(red:0.39, green:0.46, blue:0.86, alpha:1)
        self.tableView.allowsSelection = false
    }
    
    init() {
        super.init(style: UITableViewStyle.Plain)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    convenience init(networkingManger: MLEVurbNetworkManager, cardDataManager: MLEVurbCardDataManager) {
        self.init()
        self.commonInit()
        self.networkingManager = networkingManger
        self.cardDataManager = cardDataManager
    }
    
    // MARK: viewDid* viewWill* methods (View lifecycle)
    
    override func viewDidAppear(animated: Bool) {
        self.networkingManager?.getCardData({ [weak self] () -> Void in
            self?.networkFetchErrorView?.removeFromSuperview()
            self?.networkFetchErrorView = nil
            self?.tableView.reloadData()
            }, failureBlock: { [weak self] (error) -> Void in
            let networkFetchErrorView = MLECardNetworkFetchFailureView(errorText: error!.localizedDescription)
            networkFetchErrorView.backgroundColor = self?.tableView.backgroundColor
                if let view = self?.view {
                    view.addSubview(networkFetchErrorView)
                    view.addConstraint(NSLayoutConstraint(item: networkFetchErrorView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
                    view.addConstraint(NSLayoutConstraint(item: networkFetchErrorView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
                    view.addConstraint(NSLayoutConstraint(item: networkFetchErrorView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
                    view.addConstraint(NSLayoutConstraint(item: networkFetchErrorView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
                }
        })
    }
    
    // MARK: TableView configuration
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfCards = self.cardDataManager?.numberOfCards() {
            return numberOfCards
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(MLEVurbCardListTableViewController.reuseIdentifier, forIndexPath: indexPath) as! MLEVurbCardListTableViewCell
        if let cardData = self.cardDataManager?.cardDataForRow(indexPath.row) {
            tableViewCell.addCardView(MLEVurbCardViewFactory.generateCardView(cardData))
        }
        tableViewCell.backgroundColor = self.tableView.backgroundColor
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
    
    deinit {
        self.cardDataManager = nil
        self.networkingManager = nil
    }
}
