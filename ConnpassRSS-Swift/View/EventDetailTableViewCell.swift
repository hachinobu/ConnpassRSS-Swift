//
//  EventDetailTableViewCell.swift
//  ConnpassRSS-Swift
//
//  Created by Nishinobu.Takahiro on 2015/06/13.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

protocol EventDetailTableViewCellDelegate: class {
    
    func segueEventWeb()
    
}

class EventDetailTableViewCell: UITableViewCell {

    weak var delegate: EventDetailTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var catchCopyLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var recruitLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var eventWebView: UIWebView!
    @IBOutlet weak var eventDetailButton: UIButton!
    
    @IBOutlet weak var catchCopyConstraintHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
        
        eventWebView.layer.cornerRadius = 8.0
        eventWebView.layer.borderWidth = 0.8
        eventWebView.layer.borderColor = UIColor(red: 146.0/255.0, green: 153.0/255.0, blue: 163.0/255.0, alpha: 0.6).CGColor
        
        eventDetailButton.layer.cornerRadius = 8.0
        eventDetailButton.layer.borderWidth = 0.8
        eventDetailButton.backgroundColor = UIColor(red: 68.0/255.0, green: 161.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        eventDetailButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }

    func setupEventDetailCell(eventModel: EventModel) {
        
        titleLabel.attributedText = eventModel.titleInfo()
        let catchCopyInfo: (empty: Bool, attributedText: NSAttributedString) = eventModel.catchCopyInfo()
        if catchCopyInfo.empty {
            catchCopyConstraintHeight.constant = 0
            catchCopyLabel.text = ""
        }
        else {
            catchCopyLabel.attributedText = catchCopyInfo.attributedText
        }
        
        let recruitmentInfo: (color: UIColor, text: String) = eventModel.recruitment()
        recruitLabel.textColor = recruitmentInfo.color
        recruitLabel.text = recruitmentInfo.text
        
        scheduleLabel.text = eventModel.schedule()
        placeLabel.attributedText = eventModel.eventPlace()
        eventWebView.loadHTMLString(eventModel.description, baseURL: nil)
        
    }
    
    @IBAction func segueEventWebPageAction(sender: AnyObject) {
        delegate?.segueEventWeb()
    }

}
