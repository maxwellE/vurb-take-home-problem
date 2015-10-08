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
    
    // MARK: viewDid* viewWill* methods (View lifecycle)
    
    override func viewDidAppear(animated: Bool) {
        // Refactor this to store card data in a singleton manager, only do UI Changes in this
        // callback block
        MLEVurbNetworkingManager.sharedInstance.getCardData({ [weak self] () -> Void in
            self?.tableView.reloadData()
            }) { (error) -> Void in
            // Handle errors!
        }
    }
    
    // MARK: TableView configuration
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MLEVurbCardDataManager.sharedInstance.numberOfCards()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(MLEVurbTableViewController.reuseIdentifier, forIndexPath: indexPath) as! MLEVurbTableViewCell
        let cardData = MLEVurbCardDataManager.sharedInstance.cardDataForRow(indexPath.row)
        tableViewCell.addCardView(MLEVurbCardViewFactory.sharedInstance.generateCardView(cardData!))
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
}
