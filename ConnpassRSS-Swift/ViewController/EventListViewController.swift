//
//  EventListViewController.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ConnpassModelManager.loadEventWithCompletion { (connpassEvent) -> Void in
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
