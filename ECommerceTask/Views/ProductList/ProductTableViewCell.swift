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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func setProductCell(with product:ProductModel, description: NSAttributedString) {
        productImage.kf.setImage(with: product.image)
        nameLabel.text = product.name
        descriptionLabel.attributedText = description
        priceLabel.text = "\(String(describing: product.price!)) AED"
    }
    
}
