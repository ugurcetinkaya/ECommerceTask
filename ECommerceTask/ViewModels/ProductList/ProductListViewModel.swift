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
    var descriptionAttrStings: [NSAttributedString]
    var pageIndex: Int
    var shouldShowLoadingCell = false
    
    override init() {
        productList = [ProductModel]()
        descriptionAttrStings = [NSAttributedString]()
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
                        
                        let products: [ProductModel] = try! unbox(dictionary: dictionary, atKey: "hits")
                        
                        if isRefreshing {
                            self?.pageIndex = 0
                            self?.productList = products
                            
                            self?.descriptionAttrStings.removeAll()
                        }
                        else {
                            self?.productList.append(contentsOf: products)
                        }
                        
                        self?.setDescriptionAttrStings(wtih: products)
                        
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
    
    func setDescriptionAttrStings(wtih products: [ProductModel]) {
        for product in products {
            self.descriptionAttrStings.append((DataManager.stringFromHtml(string: product.description!))!)
        }
    }
}
