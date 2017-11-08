//
//  ProductModel.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import Unbox

let kImageBaseUrl = "https://prod.atgcdn.ae/small_light(p=zoom,of=undefined)/pub/media/catalog/product"

struct ProductModel {
    let productId: Int
    let name: String?
    let description: String?
    let price: Float?
    let image: URL?
    let sizes: [ProductSizeModel]?
}

extension ProductModel: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.productId = try unboxer.unbox(key: "productId")
        self.name = unboxer.unbox(key: "name")
        self.description = unboxer.unbox(key: "description")
        self.price = unboxer.unbox(key: "price")
        
        let imageUrl = kImageBaseUrl + (try unboxer.unbox(key: "image"))
        self.image = URL.init(string: imageUrl)
        
        self.sizes = unboxer.unbox(keyPath: "configurableAttributes.0.options")
        
        if let sizes = self.sizes {
            for i in 0 ..< sizes.count {
                do {
                    self.sizes![i].quantity = try unboxer.unbox(keyPath: "relatedProductsLookup.\(self.sizes![i].simpleProductSkus).stock.maxAvailableQty")
                } catch {
                    
                }
            }
        }
    }
}
