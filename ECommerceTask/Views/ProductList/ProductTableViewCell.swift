//
//  ProductTableViewCell.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 3.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!

    func setProductCell(with product:ProductModel) {
        productImage.kf.setImage(with: product.image)
        productName.text = product.name
        productDescription.attributedText = stringFromHtml(string: product.description!)
    }

    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            if let stringData = string.data(using: String.Encoding.utf8, allowLossyConversion: true) {
                let attributedString = try NSMutableAttributedString(data: stringData,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineBreakMode = .byTruncatingTail
                
                let range = NSRange(location: 0, length: attributedString.string.characters.count)
                attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
                
                return attributedString
            }
        } catch {
        }
        return nil
    }
}
