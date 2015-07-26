//
//  EventListViewController.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let EventCellIdentifier = "EventCell"
    let EventCellHeight: CGFloat = 100
    let EventPullToRefreshString = "引っ張って更新"
    let EventDetailStoryboardName = "EventDetail"
    let EventDetailSegueIdentifier = "EventDetailTableVC"
    
    @IBOutlet weak var eventsTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var eventModels = [EventModel]() {
        //newValue設定後に更新されるようにする
        didSet {
            eventsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        fetchEvents()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchEvents", forControlEvents: .ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: EventPullToRefreshString)
        
        eventsTableView.dataSource = self;
        eventsTableView.delegate = self;
        eventsTableView.addSubview(refreshControl)
    }
    
    func fetchEvents() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        APIManager.sharedInstance.call(APIManager.FetchAllEvent(params: ["keyword": "swift", "count": "20"])) { response in
            
            switch response {
            case .Success(let box):
                let connpassEvent = box.value
                if let events = connpassEvent.events {
                    self.eventModels = events
                }
                
            case .Failure(let box):
                break
                
            default:
                break
                
            }
            self.refreshControl.endRefreshing()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
        }
        
    }
    
}

// MARK: UITableViewDataSource
extension EventListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EventCellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        let event = eventModels[indexPath.row]
        let eventViewModel = EventViewModel(event: event)
        cell.setupEventModel(eventViewModel)
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return EventCellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectEvent: EventModel = eventModels[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard(name: EventDetailStoryboardName, bundle: NSBundle.mainBundle())
        let eventDetailVC = storyboard.instantiateViewControllerWithIdentifier(EventDetailSegueIdentifier) as! EventDetailTableViewController
        eventDetailVC.eventModel = selectEvent
        
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
}
