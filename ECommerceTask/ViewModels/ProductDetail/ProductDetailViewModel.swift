//
//  ProductDetailViewModel.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 7.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

import ReactiveSwift
import Unbox

final class ProductDetailViewModel: BaseViewModel {

    let kSlug = "211626543"
    
    var productDetail: ProductModel!
    var selectedSize: ProductSizeModel!
    
    func getProductDetail() -> SignalProducer<Any, NSError> {
        let parameter = ["slug" : kSlug] as [String : AnyObject]
        
        return SignalProducer { [weak self] observer, disposable in
            APIManager.request(APIManager.productDetail(parameter))
                .start({ event in
                    switch event {
                    case .value(let json):
                        let dictionary = json as! UnboxableDictionary
                        self?.productDetail = try? unbox(dictionary: dictionary)
                        
                        observer.send(value: json)
                        observer.sendCompleted()
                        break
                    case .failed(let error):
                        observer.send(error: error)
                        break
                    default:
                        break
                    }
                })
            
            
        }
    }
}
