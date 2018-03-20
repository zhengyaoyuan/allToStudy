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

enum ApiManager {
    // http://api.bangzb.com/newBang/entrance?parameter={"moduleId":1,"userId":10100171,"FuncTag":"80010012","c":204,"a":0,"platform":3}
    case getHomeColumnList(moduleId: Int)
    // http://api.bangzb.com/newBang/entrance?parameter={"userId":0,"c":204,"isTop":1,"platform":3,"a":0,"FuncTag":"80010004"}
    case getActivityList(isTop: Int)
}

fileprivate let customURLString = "http://api.bangzb.com/"
fileprivate let customPath = "newBang/entrance"

extension ApiManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: customURLString)!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        return customPath
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
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
    
    func taskCreate(with param: HTTPRequestParam) -> Task {
        if param is HttpRequestEncodedParam {
            
            return .requestPlain
        } else {
            print("不是 HttpRequestEncodedParam")
            
            let jsonEncoder = JSONEncoder()
            
            if let jsonData = try? jsonEncoder.encode(param),
                let jsonString = String(data: jsonData, encoding: .utf8) {
                
                print("最终URL：\(customURLString)\(customPath)?parameter=\(jsonString)")
                let finalDic = ["parameter": jsonString]
                
                return .requestParameters(parameters: finalDic, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
            
        }
    }
    
    var task: Task {

        switch self {
        case .getHomeColumnList(let moduleId):
            let param = HTTPRequestHomeBannerListParam(moduleId: moduleId, userId: 10100171)
            return taskCreate(with: param)
        case .getActivityList(let isTop):
            let param = HTTPRequestActivityListParam(isTop: isTop)
            return taskCreate(with: param)
        }
    }
    
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}


