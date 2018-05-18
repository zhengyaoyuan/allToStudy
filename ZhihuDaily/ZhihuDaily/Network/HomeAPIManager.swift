//
//  HomeAPIManager.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Moya

enum HomeAPIManager {
    // 获取最新新闻
    // https://news-at.zhihu.com/api/4/news/latest
    case getLatestStories

    // 过往新闻
    // https://news-at.zhihu.com/api/4/news/before/20131119
    case getStoriesBefore(date: String)
}

// 得改一种写法
fileprivate let customURLString = "https://news-at.zhihu.com/api/4/"

extension HomeAPIManager: TargetType {
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
        case .getLatestStories:
            return "news/latest"
        case .getStoriesBefore(let date):
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
