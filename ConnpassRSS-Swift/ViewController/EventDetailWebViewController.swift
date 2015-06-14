//
//  EventDetailWebViewController.swift
//  ConnpassRSS-Swift
//
//  Created by Takahiro Nishinobu on 2015/06/14.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class EventDetailWebViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    var eventURL: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let urlRequest = NSURLRequest(URL: eventURL)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
