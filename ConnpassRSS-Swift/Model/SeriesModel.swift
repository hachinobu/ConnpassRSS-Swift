//
//  SeriesModel.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

class SeriesModel: Mappable {
    
    var url: NSURL?
    var identifier: Int?
    var title: String?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        url         <- (map["url"], URLTransform())
        identifier  <- map["id"]
        title       <- map["title"]
    }
    
}