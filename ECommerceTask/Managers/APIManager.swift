//
//  APIManager.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import ReactiveSwift
import Alamofire

enum APIManager: URLRequestConvertible {
    
    static let baseServiceURL = NSURL(string: Bundle.main.infoDictionary?["BaseURL"] as! String)!
    
    var requestURL: URL {
        return APIManager.baseServiceURL.appendingPathComponent(route.path)!
    }
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.queryString.encode(urlRequest, with: route.parameters)
    }
    
    static func request(_ url: URLRequestConvertible) -> SignalProducer<Any, NSError> {
        return SignalProducer { observer, disposable in
            Alamofire.request(url).responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    observer.send(value: value)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error as NSError)
                }
            })
        }
    }
    
    case productList([String: AnyObject])
    
    var route: (path: String, parameters: [String: AnyObject]?) {
        
        switch self {
        case .productList(let parameters):
            return ("search/full", parameters)
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .productList:
            return .post
        }
        
    }
}
