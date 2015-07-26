//
//  APIManager.swift
//  ConnpassRSS-Swift
//
//  Created by Takahiro Nishinobu on 2015/07/26.
//  Copyright (c) 2015年 hachinobu. All rights reserved.
//

import UIKit

class Box<T> {
    let value: T
    
    init(_ value: T) {
        self.value = value
    }
}

protocol APIRequest {
    var method: String { get }
    var path: String { get }
    var params: [String: AnyObject]? { get }
    var tokenCheck: Bool { get }
    
    typealias Response: Any
    
    func convertJSONObject(object: AnyObject) -> Response?
}

enum Response<T> {
    case Success(Box<T>)
    case Failure(Box<NSError>)
    
    init(_ value: T) {
        self = .Success(Box(value))
    }
    
    init(_ error: NSError) {
        self = .Failure(Box(error))
    }
}

class APIManager {
    
    static let sharedInstance = APIManager()
    let kBaseURL = "http://connpass.com/api/v1/event"
    
    func call<T: APIRequest>(apiRequest: T, handler: (Response<T.Response>) -> Void = { r in  }) {
        
        let URL = NSURL(string: kBaseURL + apiRequest.path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = apiRequest.method
        
        if apiRequest.tokenCheck {
            mutableURLRequest.setValue("Token token=\"", forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlRequest = ParameterEncoding.URL.encode(mutableURLRequest, parameters: apiRequest.params).0
        request(urlRequest)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (req, res, result, error) -> Void in
                
                if let e = error {
                    handler(Response(e))
                }
                else {
                    var a = apiRequest.convertJSONObject(result!)
                    handler(Response(a!))
                }
        }
    }
}

extension APIManager {
    
    //イベント一覧取得
    class FetchAllEvent: APIRequest {
        
        let method = "GET"
        let path = ""
        var params : Dictionary<String, AnyObject>?
        let tokenCheck = false
        
        typealias Response = ConnpassModel
        
        init(params :Dictionary<String, NSObject>) {
            self.params = params
        }
        
        func convertJSONObject(object: AnyObject) -> Response? {
            var connpassModel: ConnpassModel?
            if let dictionary = object as? NSDictionary {
                connpassModel = Mapper<ConnpassModel>().map(dictionary)
            }
            return connpassModel
        }
        
    }
    
    
}



















