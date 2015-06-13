//
//  EventTableViewCell.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/09.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var personsLabel: UILabel!
    @IBOutlet weak var hashTagLabel: UILabel!
    
    override func awakeFromNib() {
        self.accessoryType = .DisclosureIndicator
    }
    
    func setupEventModel(model: EventModel) {
        
        scheduleLabel.text = model.schedule()
        
        titleLabel.attributedText = model.titleInfo()
        
        let recruitment: (color: UIColor, text: String) = model.recruitment()
        personsLabel.textColor = recruitment.color
        personsLabel.text = recruitment.text
        
        hashTagLabel.text = model.hashTag ?? ""
        
    }
    
}
