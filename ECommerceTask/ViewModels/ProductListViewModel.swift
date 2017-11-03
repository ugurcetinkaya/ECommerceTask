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

    let kSearchString = "boy"
    let kHitsPerPage = 10
    
    var productList: [ProductModel]
    var pageIndex: Int
    var shouldShowLoadingCell = false
    
    override init() {
        productList = [ProductModel]()
        pageIndex = 0
    }
    
    func getProductList(isRefreshing: Bool) -> SignalProducer<Any, NSError> {
        let parameter = ["searchString" : kSearchString,
                         "page" : pageIndex,
                         "hitsPerPage" : kHitsPerPage
                         ] as [String : AnyObject]
        
        return SignalProducer { [weak self] observer, disposable in
            APIManager.request(APIManager.productList(parameter))
                .start({ event in
                    switch event {
                    case .value(let json):
                        let dictionary = json as! UnboxableDictionary
                        
                        if isRefreshing {
                            self?.pageIndex = 0
                            self?.productList = try! unbox(dictionary: dictionary, atKey: "hits")
                        }
                        else {
                            self?.productList.append(contentsOf: try! unbox(dictionary: dictionary, atKey: "hits"))
                        }
                        
                        let pagination = dictionary["pagination"] as! [String : Int]
                        self?.shouldShowLoadingCell = (self?.pageIndex)! < (Int)(pagination["totalPages"]!)
                        
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
