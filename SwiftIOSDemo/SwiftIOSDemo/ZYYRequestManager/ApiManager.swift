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
}

enum ApiManager {
    case getHomeColumnList(moduleId: Int)
    case getActivityList(isTop: Int)
//    case getDantangList(String)
//    case getNewsList
//    case getMoreNews(String)
//    case getThemeList
//    case getThemeDesc(Int)
//    case getNewsDesc(Int)
//    case Create(title: String, body: String, userId: Int)
//    case Login(phone:String,password:String)
//    case Banner(String)
}

extension ApiManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    
    /// The target's base `URL`.
    var baseURL: URL {
        
        return URL.init(string: "http://api.bangzb.com/")!
//        switch self {
//        case .Create(_,_,_):
//            return URL.init(string: "http://jsonplaceholder.typicode.com/")!
//        case .getDantangList,.Banner:
//            return URL.init(string: "http://api.dantangapp.com/")!
//        case .Login:
//            return URL.init(string: "https://api.grtstar.cn")!
//        default:
//            return URL.init(string: "http://news-at.zhihu.com/api/")!
//        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        return "newBang/entrance"
//        switch self {
//        case .getDantangList(let page):
//            return "v1/channels/\(page)/items"
//        case .getNewsList:
//            return "4/news/latest"
//        case .getMoreNews(let date):
//            return "4/news/before/" + date
//        case .getThemeList:
//            return "4/themes"
//        case .getThemeDesc(let id):
//            return "4/theme/\(id)"
//        case .getNewsDesc(let id):
//            return "4/news/\(id)"
//        case .Create(_, _, _):
//            return "posts"
//        case .Login:
//            return "/rest/user/certificate"
//        case .Banner:
//            return "v1/banners"
//
//        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        switch self {
        
        default:
//            return .get
            return .post
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
    
    
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        
        
        
        var dic = ["platform": 3, "a": 0, "c": Bundle.main.infoDictionary!["StoreID"]!]
        
        
        switch self {
        case .getHomeColumnList(let moduleId):
            let individialDic = ["moduleId": moduleId]
            
            dic.update(other: individialDic)
            
            return dic
        
//        default:
//            return nil
        case .getActivityList(let isTop):
            let individialDic = ["isTop": isTop]
            dic.update(other: individialDic)
            
            let finalDic = ["parameter": dic]
            
            return finalDic

        }
        
        
//        switch self {
//        case .Create(let title, let body, let userId):
//            return ["title": title, "body": body, "userId": userId]
//
//        case .Login(let number, let passwords):
//            return ["mobile" : number, "password" :  passwords,"deviceId": "12121312323"]
//        case .Banner(let strin):
//            return ["channel" :strin]
//
//        default:
//            return nil
//
//        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
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
            
            let dic = ["platform": 3, "a": 0, "c": 255, "isTop": isTop, "FuncTag": "80010004", "userId": 0] as [String : Any]
            
            let data : NSData! = try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData!
            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)

            let finalDic = ["parameter": JSONString!]
            
            return .requestParameters(parameters: finalDic, encoding: URLEncoding.queryString)
//        default:
//            .requestPlain
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}


