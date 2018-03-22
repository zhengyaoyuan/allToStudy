//
//  ZYYApiManager.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Moya

let ZYYApiManagerProvider = MoyaProvider<ZYYApiManager>()

enum ZYYApiManager {
    // 获取最新新闻
    // https://news-at.zhihu.com/api/4/news/latest
    case getLatestNews
    // 过往新闻
    // https://news-at.zhihu.com/api/4/news/before/20131119
    case getNewsBefore(date: String)
}

fileprivate let customURLString = "https://news-at.zhihu.com/api/4/"

extension ZYYApiManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: customURLString)!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getLatestNews:
            return "news/latest"
        case .getNewsBefore(let date):
            return "news/before/\(date)"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
