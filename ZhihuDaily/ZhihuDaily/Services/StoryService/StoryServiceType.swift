//
//  StoryServiceType.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift

protocol StoryServiceType {
    func latestStories() -> Observable<NewAndTopStory>
}
