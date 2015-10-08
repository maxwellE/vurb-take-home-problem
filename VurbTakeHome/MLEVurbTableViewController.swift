//
//  MLEVurbTableViewController.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbTableViewController: UITableViewController {
    static let reuseIdentifier = "CardCell"
    var cardDataArray : Array<String> = Array<String>()
    var networkingManager : MLEVurbNetworkingProtocol?
    var cardDataManager : MLEVurbCardDataProtocol?
    var cardViewFactory : MLEVurbCardViewFactoryProtocol?
    
    // MARK: Initializers
    
    func commonInit() {
        self.tableView.registerClass(MLEVurbTableViewCell.classForCoder(), forCellReuseIdentifier: MLEVurbTableViewController.reuseIdentifier)
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
    
    convenience init(networkingManger: MLEVurbNetworkingProtocol, cardDataManager: MLEVurbCardDataProtocol, cardViewFactory: MLEVurbCardViewFactoryProtocol) {
        self.init()
        self.commonInit()
        self.networkingManager = networkingManger
        self.cardDataManager = cardDataManager
        self.cardViewFactory = cardViewFactory
    }
    
    // MARK: viewDid* viewWill* methods (View lifecycle)
    
    override func viewDidAppear(animated: Bool) {
        // Refactor this to store card data in a singleton manager, only do UI Changes in this
        // callback block
        self.networkingManager?.getCardData({ [weak self] () -> Void in
            self?.tableView.reloadData()
            }, failureBlock: { (error) -> Void in
                // HANDLE FAILURE
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
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(MLEVurbTableViewController.reuseIdentifier, forIndexPath: indexPath) as! MLEVurbTableViewCell
        if let cardData = self.cardDataManager?.cardDataForRow(indexPath.row) {
            if let cardView = self.cardViewFactory?.generateCardView(cardData) {
                tableViewCell.addCardView(cardView)
            }
        }
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
}
