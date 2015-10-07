//
//  MLEVurbTableViewController.swift
//  VurbTakeHome
//
//  Created by Maxwell Elliott on 10/6/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import UIKit

class MLEVurbTableViewController: UITableViewController {
    let reuseIdentifier = "CardCell"
    var cardDataArray : Array<String> = Array<String>()
    
    // MARK: Initializers
    
    func commonInit() {
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
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
        MLEVurbNetworkingManager.sharedInstance.getCardData({ (responseDictionary) -> Void in
            let cardsData = responseDictionary["cards"] as! NSArray
            for rawCardData in cardsData {
                let cardInfo = rawCardData as! NSDictionary
                let cardData = CardData.init(cardInfo: cardInfo)
                print(cardData.title)
            }
            }) { (error) -> Void in
                
        }
    }
    
    // MARK: TableView configuration
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
    }
}
