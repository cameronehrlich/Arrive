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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        selectedBackgroundView = nil
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = UIColor(red:0.39, green:0.25, blue:0.49, alpha:0.5)
        }
        else {
            backgroundColor = nil
        }
    }
    
}
