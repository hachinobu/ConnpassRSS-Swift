//
//  EventViewModel.swift
//  ConnpassRSS-Swift
//
//  Created by Takahiro Nishinobu on 2015/06/28.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation
import UIKit

class EventViewModel: NSObject {
   
    let eventModel: EventModel
    
    let UnfixedSchedule = "開催日未定"
    let ParticipationCondition = "参加状況"
    let PersonUnit = "人"
    let Substitute = "補欠者数"
    let LineSpacing: CGFloat = 5.0
    var paragraphStyle = NSMutableParagraphStyle()
    
    init(event: EventModel) {
        eventModel = event
    }
    
    func schedule() -> String {
        
        var startedTime = DateUtil.formatScheduleFromDate(eventModel.startedAt, format: "MM月dd日 HH:mm")
        if count(startedTime) == 0 {
            return UnfixedSchedule
        }
        
        let endedTime = DateUtil.formatScheduleFromDate(eventModel.endedAt, format: "HH:mm")
        if count(endedTime) > 0 {
            return startedTime + "〜" + endedTime
        }
        
        return UnfixedSchedule
        
    }
    
    func recruitment() -> (color: UIColor, text: String) {
        
        if let limitNumber = eventModel.limit, let acceptedNumber = eventModel.accepted where
            limitNumber > 0 && acceptedNumber >= 0 {
                
                var currentState = ParticipationCondition + " " + String(acceptedNumber) + "/" + String(limitNumber)
                if let waitingNumber = eventModel.waiting where waitingNumber > 0 {
                    
                    currentState += " \(Substitute)\(String(waitingNumber))\(PersonUnit)"
                    return (UIColor.redColor(), currentState)
                    
                }
                return (UIColor.blackColor(), currentState)
        }
        return (UIColor.blackColor(), "未確定")
        
    }
    
    func titleInfo() -> NSAttributedString {
        
        paragraphStyle.lineSpacing = LineSpacing
        let attributedText = NSMutableAttributedString(string: eventModel.title ?? "タイトル未定")
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        return attributedText as NSAttributedString
        
    }
    
    func catchCopyInfo() -> (empty: Bool, attributedText: NSAttributedString) {
        
        paragraphStyle.lineSpacing = LineSpacing
        let attributedText = NSMutableAttributedString(string: eventModel.catch ?? "")
        if count(attributedText.string) == 0 {
            return (true, attributedText as NSAttributedString)
        }
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return (false, attributedText as NSAttributedString)
        
    }
    
    func eventPlace() -> NSAttributedString {
        
        paragraphStyle.lineSpacing = LineSpacing
        var addressPlace = ""
        if let eventAddress = eventModel.address where count(eventAddress) > 0 {
            addressPlace += eventAddress
        }
        
        if let eventPlace = eventModel.place where count(eventPlace) > 0 {
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
