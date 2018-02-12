//
//  ZYYRequestManager.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Alamofire

struct ConstAPI {
    
    static let baseURL: String = "http://api.bangzb.com:8081/newBang/entrance"
    
//    //首页微游记
//    static let kAPIHomeMoment: String = kAPIBaseURL + ""
//
//    // 首页目的地
//    static let kAPIHomeDestination: String = kAPIBaseURL + ""
//
    
}

class ZYYRequestManager: NSObject {
    
    static let shared = ZYYRequestManager()
    
    static let jsonEncoder = JSONEncoder()
    
//    private override init() {
//        // 单例模式，防止出现多个实例
//    }
    
    func requestWithURL(method: HTTPMethod = .get, url: String = ConstAPI.baseURL, parameter: [String: AnyObject]? = nil, success: @escaping (_ result: [String: AnyObject]) -> Void ,failure: @escaping (_ error: Error) -> Void) -> Void {
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default).responseJSON { response in

            if response.error != nil {
                failure(response.error!)
                return;
            }


            if let JSON = response.result.value {
                success(JSON as! [String: AnyObject])
            }



            return
        }
    }
}

extension ZYYRequestManager {
//    func modelToJson(param: HTTPRequestParam) -> String? {
//        let jsonData: Data
//        do {
//            try jsonData = ZYYRequestManager.jsonEncoder.encode(param)
//        } catch <#pattern#> {
//            <#statements#>
//        }
//
//
//        return String(data: jsonData, encoding: .utf8)
//    }
    
    func getHomeBannerList(success: @escaping (_ result: [String: AnyObject]) -> Void ,failure: @escaping (_ error: Error) -> Void) -> Void {
        let param = HTTPRequestHomeBannerListParam(userId: 2090278)
        
        
//            requestWithURL(parameter: nil, success: success, failure: failure)
        
    }
}
