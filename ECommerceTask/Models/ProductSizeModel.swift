//
//  ProductSizeModel.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 8.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import Unbox

struct ProductSizeModel {
    let simpleProductSkus: Int
    let label: String?
    let isInStock: Bool?
    var quantity = 0
}

extension ProductSizeModel: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.simpleProductSkus = try unboxer.unbox(keyPath: "simpleProductSkus.0")
        self.label = unboxer.unbox(key: "label")
        self.isInStock = unboxer.unbox(key: "isInStock")
    }
}
