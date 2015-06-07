//
//  ConnpassModel.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

class ConnpassModel: Mappable {
    
    var resultCount: Int?
    var resultWordCount: Int?
    var resultStartCount: Int?
    var events: [EventModel]?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        resultCount         <- map["results_returned"]
        resultWordCount     <- map["results_available"]
        resultStartCount    <- map["results_start"]
        events              <- map["events"]
        
    }
    
}