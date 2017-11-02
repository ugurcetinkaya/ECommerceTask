//
//  ProductModel.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import Unbox

struct ProductModel {
    let productId: Int
    let name: String?
    let description: String?
    let image: URL?
}

extension ProductModel: Unboxable {
    init(unboxer: Unboxer) throws {
        self.productId = try unboxer.unbox(key: "productId")
        self.name = unboxer.unbox(key: "name")
        self.description = unboxer.unbox(key: "description")
        self.image = unboxer.unbox(key: "profile_picture")
    }
}
