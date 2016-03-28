//
//  FlightTableViewCell.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/28/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    static let identifier: String = "FlightCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        textLabel?.font = UIFont.sk_boldFont(16)
        detailTextLabel?.font = UIFont.sk_boldFont(16)
        detailTextLabel?.textColor = UIColor.darkTextColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = UIColor.sk_purpleColor().colorWithAlphaComponent(0.2)
        }
        else {
            backgroundColor = nil
        }
    }
    
}
