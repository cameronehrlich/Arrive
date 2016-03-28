//
//  AirportTableViewCell.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/27/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {
    
    static let identifier: String = "AirportCell"
    
    var airport: Airport? {
        didSet {
            textLabel?.text = "\(airport!.airportCode!) ✈︎ \(airport!.name!)"
            detailTextLabel?.text = "• \(airport!.city!) "
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        textLabel?.font = UIFont.sk_boldFont(17)
        textLabel?.textColor = UIColor.sk_purpleColor()
        
        detailTextLabel?.font = UIFont.sk_regularFont(13)
        detailTextLabel?.textColor = UIColor.sk_purpleColor().colorWithAlphaComponent(0.80)
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
