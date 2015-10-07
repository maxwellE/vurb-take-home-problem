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
            print(MLEVurbCardDataManager.sharedInstance.numberOfCards())
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
//        if let cardData = MLEVurbCardDataManager.sharedInstance.cardDataForRow(indexPath.row) {
            return tableView.dequeueReusableCellWithIdentifier(MLEVurbTableViewController.reuseIdentifier, forIndexPath: indexPath)
//        }
    }
}
