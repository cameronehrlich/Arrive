//
//  NavigationBar.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/28/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = UIColor.sk_purpleColor()
        
        let navigationBarAppearace = UINavigationBar.appearance()
        let font = UIFont.sk_boldFont(17)
        navigationBarAppearace.titleTextAttributes = [NSFontAttributeName : font,
                                                      NSForegroundColorAttributeName : UIColor.darkTextColor()];

    }
}
