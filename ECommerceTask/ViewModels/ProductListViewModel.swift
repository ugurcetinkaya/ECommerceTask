//
//  ProductListViewModel.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import ReactiveSwift
import Unbox

final class ProductListViewModel: BaseViewModel {

    var productList: [ProductModel]
    var pageIndex: Int
    
    override init() {
        productList = [ProductModel]()
        pageIndex = 0
    }
    
    func getProductList() -> SignalProducer<Any, NSError> {
        let parameter = ["searchString" : "boy",
                         "page" : pageIndex,
                         "hitsPerPage" : 10
                         ] as [String : AnyObject]
        
        return SignalProducer { [weak self] observer, disposable in
            APIManager.request(APIManager.productList(parameter))
                .start({ event in
                    switch event {
                    case .value(let json):
                        let dictionary = json as! UnboxableDictionary
                        
                        self?.productList.append(contentsOf: try! unbox(dictionary: dictionary, atKey: "hits"))
                        
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
