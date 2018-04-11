//
//  ZYYMainViewModel.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import Moya

let provider = MoyaProvider<MultiTarget>()

enum RequestResult {
    case ok(data: ZYYResponseModel)
    case failed(message: String)
}

class ZYYMainViewModel {

    let disposeBag = DisposeBag()

    fileprivate let responseModels: Driver<RequestResult>
    
    
    
    let stories: Driver<[ZYYNormalStoryModel]>
    
//    init(o: Driver<String>) {
//        // 点击按钮 触发
//        responseModels = o.flatMapLatest { _  in
//            return ZYYApiManagerProvider.rx
//                .request(.getLatestStories)
//                .filterSuccessfulStatusCodes()
//                // mapJSON 会发出 single 信号 是 Observable 的变种
//                .mapJSON()
//                .asObservable()
//                .mapObject(type: ZYYResponseModel.self)
//                .map { model -> RequestResult in
//                    return .ok(data: model)
//                }
//                .asDriver(onErrorJustReturn: .failed(message: "error"))
//        }
//        
//        stories = responseModels.map { result in
//            switch result {
//            case .ok(let data):
//                if let models = data.stories {
//                    return models
//                }
//            case .failed(let message):
//                print(message)
//            }
//            
//            return []
//        }
//    }

    init(refreshTap: Signal<Void>) {
        // 点击按钮 触发
        responseModels = refreshTap.flatMapLatest { _  in
            return provider.rx
                .request(MultiTarget(ZYYApiManager.getLatestStories))
//                return ZYYApiManagerProvider.rx.request(.getLatestStories)
                .filterSuccessfulStatusCodes()
                // mapJSON 会发出 single 信号 是 Observable 的变种
                .mapJSON()
                .asObservable()
                .mapObject(type: ZYYResponseModel.self)
                .map { model -> RequestResult in
                    return .ok(data: model)
                }
                .asDriver(onErrorJustReturn: .failed(message: "error"))
        }
        
        stories = responseModels.map { result in
            switch result {
            case .ok(let data):
                if let models = data.stories {
                    return models
                }
            case .failed(let message):
                print(message)
            }
            
            return []
        }
    }
}

