//
//  EventModel.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

class EventModel: Mappable {
    
    var identifier: Int?
    var title: String?
    var catch: String?
    var description: String?
    var url: NSURL?
    var hashTag: String?
    var startedAt: NSDate?
    var endedAt: NSDate?
    var limit: Int?
    var type: String?
    var series: SeriesModel?
    var address: String?
    var place: String?
    var lat: String?
    var lon: String?
    var ownerId: Int?
    var ownerNickName: String?
    var ownerDisplayName: String?
    var accepted: Int?
    var waiting: Int?
    var updatedAt: NSDate?
    
    let hashTagTransformOf = TransformOf<String, String>(fromJSON: { (value: String?) -> String? in
        if let value = value where count(value) > 0 {
            return "#" + value
        }
        return ""
    }, toJSON: { (value: String?) -> String? in
        if let value = value {
            return value
        }
        return nil
    })
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        identifier          <- map["event_id"]
        title               <- map["title"]
        catch               <- map["catch"]
        description         <- map["description"]
        url                 <- (map["event_url"], URLTransform())
        hashTag             <- (map["hash_tag"], hashTagTransformOf)
        startedAt           <- (map["started_at"], ISO8601DateTransform())
        endedAt             <- (map["ended_at"], ISO8601DateTransform())
        limit               <- map["limit"]
        type                <- map["event_type"]
        series              <- map["series"]
        address             <- map["address"]
        place               <- map["place"]
        lat                 <- map["lat"]
        lon                 <- map["lon"]
        ownerId             <- map["owner_id"]
        ownerNickName       <- map["owner_nickname"]
        ownerDisplayName    <- map["owner_display_name"]
        accepted            <- map["accepted"]
        waiting             <- map["waiting"]
        updatedAt           <- (map["updated_at"], ISO8601DateTransform())
        
    }
    
}