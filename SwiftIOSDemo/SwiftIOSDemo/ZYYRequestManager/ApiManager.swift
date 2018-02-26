//
//  ApiManager.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Moya

let ApiManagerProvider = MoyaProvider<ApiManager>()

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    
    func convertToJson() -> String? {
        
        if let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0)),
           let JSONString = String(data: data, encoding: String.Encoding.utf8) {
            return JSONString
        } else {
            return nil
        }
    }
}

enum ApiManager {
    case getHomeColumnList(moduleId: Int)
    case getActivityList(isTop: Int)
}

extension ApiManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    
    /// The target's base `URL`.
    var baseURL: URL {
        
        return URL.init(string: "http://api.bangzb.com/")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        return "newBang/entrance"
//        switch self {
//        case .getDantangList(let page):
//            return "v1/channels/\(page)/items"
//        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        switch self {
        
        default:
            return .get
        }
        
//        switch self {
//            
//        case .Create(_, _, _):
//            return .post
//        case .Login:
//            return .post
//        default:
//            return .get
//        }
        
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
//        switch self {
//        case .Create(_, _, _):
//            return "Create post successfully".data(using: String.Encoding.utf8)!
//        default:
//            return "".data(using: String.Encoding.utf8)!
        
//        }
    }
    
    var task: Task {
        
        var dic = ["platform": 3, "a": 0, "c": Bundle.main.infoDictionary!["StoreID"]!]
        
        switch self {
        case .getHomeColumnList(let moduleId):
            let individialDic = ["moduleId": moduleId]
            
            dic.update(other: individialDic)
            
            return .requestParameters(parameters: dic, encoding: URLEncoding.queryString)
        case .getActivityList(let isTop):
            
            dic.update(other: ["FuncTag": "80010004", "isTop": isTop])
            
            if let jsonString = dic.convertToJson() {
                let finalDic = ["parameter": jsonString]
                return .requestParameters(parameters: finalDic, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}


