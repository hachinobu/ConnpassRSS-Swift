//
//  ConnpassModelManager.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

class ConnpassModelManager {
    
    class func loadEventWithCompletion(completion: (ConnpassModel!) -> Void) {
        
        ConnpassEventRequestManager.requestConnpassEvents { (request, response, jsonString, error) -> Void in
            if error == nil {
                let json = JSON(jsonString!)
                let connpassModel: ConnpassModel? = Mapper<ConnpassModel>().map(json.rawString()!)
                if let connpass = connpassModel {
                    completion(connpass)
                }
            }
        }
    }
}