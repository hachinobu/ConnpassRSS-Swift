//
//  EventModel.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/06.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation
import UIKit

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
    
    //Cell用
    let UnfixedSchedule = "開催日未定"
    let ParticipationCondition = "参加状況"
    let PersonUnit = "人"
    let Substitute = "補欠者数"
    let LineSpacing: CGFloat = 5.0
    let paragraphStyle = NSMutableParagraphStyle()
    
    //ハッシュタグの先頭に#つける
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

// MARK: View用に
extension EventModel {
    
    func schedule() -> String {
        
        var startedTime = DateUtil.formatScheduleFromDate(startedAt, format: "MM月dd日 HH:mm")
        if count(startedTime) == 0 {
           return UnfixedSchedule
        }
        
        let endedTime = DateUtil.formatScheduleFromDate(endedAt, format: "HH:mm")
        if count(endedTime) > 0 {
            return startedTime + "〜" + endedTime
        }
        
        return UnfixedSchedule
        
    }
    
    func recruitment() -> (color: UIColor, text: String) {
        
        if let limitNumber = self.limit, let acceptedNumber = self.accepted where
            limitNumber > 0 && acceptedNumber >= 0 {
                
                var currentState = ParticipationCondition + " " + String(acceptedNumber) + "/" + String(limitNumber)
                if let waitingNumber = self.waiting where waitingNumber > 0 {
                    
                    currentState += " \(Substitute)\(String(waitingNumber))\(PersonUnit)"
                    return (UIColor.redColor(), currentState)
                    
                }
                return (UIColor.blackColor(), currentState)
        }
        return (UIColor.blackColor(), "未確定")
        
    }
    
    func titleInfo() -> NSAttributedString {
        
        paragraphStyle.lineSpacing = LineSpacing
        let attributedText = NSMutableAttributedString(string: title ?? "タイトル未定")
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        return attributedText as NSAttributedString
        
    }
    
    func catchCopyInfo() -> (empty: Bool, attributedText: NSAttributedString) {
        
        paragraphStyle.lineSpacing = LineSpacing
        let attributedText = NSMutableAttributedString(string: catch ?? "")
        if count(attributedText.string) == 0 {
            return (true, attributedText as NSAttributedString)
        }
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return (false, attributedText as NSAttributedString)
        
    }
    
    func eventPlace() -> NSAttributedString {
        
        paragraphStyle.lineSpacing = LineSpacing
        var addressPlace = ""
        if let eventAddress = address where count(eventAddress) > 0 {
            addressPlace += eventAddress
        }
        
        if let eventPlace = place where count(eventPlace) > 0 {
            addressPlace += eventPlace
        }
        
        let attributedText: NSMutableAttributedString
        if count(addressPlace) > 0 {
            attributedText = NSMutableAttributedString(string: "場所：" + addressPlace)
        }
        else {
            attributedText = NSMutableAttributedString(string: "開催地未定")
        }
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText as NSAttributedString
        
    }
        
}




