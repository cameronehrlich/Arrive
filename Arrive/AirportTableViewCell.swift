//
//  AirportTableViewCell.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/27/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {
    
    static let identifier: String = "Airport"
    
    let separatorLine = UIView(forAutoLayout: ())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        textLabel?.font = UIFont.sk_boldFont(21)
        detailTextLabel?.font = UIFont.sk_regularFont(12)
        detailTextLabel?.textColor = UIColor.darkTextColor()
        
        
        separatorLine.backgroundColor = UIColor.sk_purpleColor()
        addSubview(separatorLine)
        separatorLine.autoSetDimension(.Height, toSize: 1.0)
        separatorLine.autoPinEdgeToSuperviewEdge(.Bottom)
        separatorLine.autoPinEdgeToSuperviewMargin(.Left)
        separatorLine.autoPinEdgeToSuperviewMargin(.Right)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = UIColor.sk_purpleColor().colorWithAlphaComponent(0.2)
            separatorLine.hidden = true
        }
        else {
            backgroundColor = nil
            separatorLine.hidden = false
        }
    }
    
}
