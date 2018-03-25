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

enum RequestResult {
    case ok(data: ZYYResponseModel)
    case failed(message: String)
}

class ZYYMainViewModel {

    let disposeBag = DisposeBag()

    // 故事的数据
//    var responseModels: [ZYYResponseModel]?
    
//    let responseModels: Driver<RequestResult>
    
//    let stories: Driver<[ZYYNormalStoryModel]>
    
    

//    init(refreshTap: Signal<Void>) {
//        // 点击按钮 触发
//        responseModels = refreshTap.flatMapLatest { _ in
//            return ZYYApiManagerProvider.rx
//                .request(.getLatestStories)
//                .filterSuccessfulStatusCodes()
//                .mapJSON()
//                .asObservable()
//                .mapObject(type: ZYYResponseModel.self)
//                .map { model -> RequestResult in
//                    return .ok(data: model)
//            }
//                .asDriver(onErrorJustReturn: .failed(message: String))
//        }
//    }
    
//    func requestLatestStories() {
//        ZYYApiManagerProvider.rx
//            .request(.getLatestStories)
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//            .asObservable()
//            .mapObject(type: ZYYResponseModel.self)
//            .asDriver(onErrorJustReturn: <#T##ZYYResponseModel#>)
//            .subscribe(onSuccess: { [weak self] json in
//                guard let strongSelf = self else {
//                    return
//                }
//                strongSelf.responseModels = Mapper<ZYYResponseModel>().mapArray(JSONObject: json)
//            }) { error in
//                print(error)
//        }
//        .disposed(by: disposeBag)
        
        
//    }
 
}

