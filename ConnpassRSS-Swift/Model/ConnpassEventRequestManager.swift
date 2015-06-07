//
//  ConnpassEventRequestManager.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

class ConnpassEventRequestManager {
    
    static let baseURL = "http://connpass.com/api/v1/event"
    
    class func requestConnpassEvents(completion: (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) {
        
        request(.GET, baseURL, parameters: ["keyword": "swift", "count": "20"])
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
        
    }
    
}