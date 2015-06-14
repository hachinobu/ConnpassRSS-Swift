//
//  EventDetailTableViewController.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/13.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {

    let NavigationTitleName = "イベント"
    let EventDetailCellIdentifier = "EventDetailCell"
    let EventDetailWebStoryboardName = "EventDetailWeb"
    
    var eventModel: EventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NavigationTitleName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: StoryboardでStatic Cellsを使っているがカスタムなTableViewCellを使う際に必要な処理
extension EventDetailTableViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! EventDetailTableViewCell
        cell.delegate = self
        cell.setupEventDetailCell(eventModel)
        
        return cell
    }
    
}

// MARK: EventDetailTableViewCellDelegate
extension EventDetailTableViewController: EventDetailTableViewCellDelegate {
    
    func segueEventWeb() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: EventDetailWebStoryboardName, bundle: NSBundle.mainBundle())
        let webNavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let eventWebViewController = webNavigationController.topViewController as! EventDetailWebViewController
        eventWebViewController.eventURL = eventModel.url ?? NSURL()
        self.presentViewController(webNavigationController, animated: true) { () -> Void in
            
        }
    }
    
}
