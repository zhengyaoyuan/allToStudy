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

class ZYYMainViewModel {

    let disposeBag = DisposeBag()

    // 故事的数据
//    let stories: Driver<[ZYYNormalStoryModel]>

    init(refreshTap: Signal<Void>) {
        // 出发
//        stories = refreshTap.flatMapLatest { _ in
//            return ZYYApiManagerProvider.rx
//                .request(.getLatestStories)
//                .filterSuccessfulStatusCodes()
//                .mapJSON()
//                .asDriver(onErrorJustReturn: false)
//        }
    }
    
    
    func requestLatestStories() {

        ZYYApiManagerProvider.rx
            .request(.getLatestStories)
            .filterSuccessfulStatusCodes()
            .mapJSON()


        
    }
}

