//
//  StoryService.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct StoryService: StoryServiceType {

    func latestStories() -> Observable<NewAndTopStory> {
        return apiProvider.rx
            .request(MultiTarget(HomeAPIManager.getLatestStories))
            .map(NewAndTopStory.self)
            .asObservable()
    }
}
