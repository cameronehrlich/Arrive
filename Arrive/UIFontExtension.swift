//
//  UIFontExtension.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/28/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func sk_regularFont(size: Float) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: CGFloat(size))!
    }
    
    class func sk_lightFont(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Light", size: CGFloat(size))!
    }
    
    class func sk_boldFont(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: CGFloat(size))!
    }
}
