//
//  StyleManager.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 3.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit
import SwiftHEXColors

extension UIColor {
    
    @nonobjc class var navigationBar: UIColor {
        return UIColor(hexString: "313B47")!
    }
    
    @nonobjc class var navigationBarTitle: UIColor {
        return UIColor(hexString: "FCFCFC")!
    }

}

extension UIFont {
    
    class func font(weight: UIFontWeight, size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
}
