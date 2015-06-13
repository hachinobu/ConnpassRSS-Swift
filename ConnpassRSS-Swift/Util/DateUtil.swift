//
//  DateUtil.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/10.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import Foundation

let formatter = NSDateFormatter()

class DateUtil {
    
    class func formatScheduleFromDate(date: NSDate?, format: String?) -> String {
        
        if let constDate = date, let dateFormat = format {
            
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.dateFormat = dateFormat
            return formatter.stringFromDate(constDate)
            
        }
        return ""
        
    }
    
}