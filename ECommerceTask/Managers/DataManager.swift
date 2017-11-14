//
//  DataManager.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 8.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

struct DataManager {

    static func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            if let stringData = string.data(using: String.Encoding.utf8, allowLossyConversion: true) {
                let attributedString = try NSMutableAttributedString(data: stringData,
                                                                     options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                                     documentAttributes: nil)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineBreakMode = .byTruncatingTail
                
                let range = NSRange(location: 0, length: attributedString.string.count)
                attributedString.addAttributes([NSParagraphStyleAttributeName : paragraphStyle,
                                                NSFontAttributeName : UIFont.font(weight: UIFontWeightLight, size: 12)],
                                               range: range)
                
                return attributedString
            }
        } catch {
        }
        return nil
    
    }
}
