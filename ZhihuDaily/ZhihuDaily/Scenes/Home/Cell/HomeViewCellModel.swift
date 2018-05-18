//
//  HomeViewCellModel.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewCellModelInput {
//    var hasReadStory: BehaviorSubject<Bool> { get }

}

protocol HomeViewCellModelOutput {
    var leftTitle: Observable<String>! { get }
    var rightImage: Observable<String>! { get }
    var hasMutipleImages: Observable<Bool>! { get }
}

protocol HomeViewCellModelType {
    var inputs: HomeViewCellModelInput { get }
    var outputs: HomeViewCellModelOutput { get }
}


class HomeViewCellModel: HomeViewCellModelType,
                         HomeViewCellModelInput,
                         HomeViewCellModelOutput {

    // MARK: Inputs & Outputs
    var inputs: HomeViewCellModelInput { return self }
    var outputs: HomeViewCellModelOutput { return self }

    // MARK: Input
//    let hasReadStory = BehaviorSubject<Bool>(value: false)

    // MARK: Output
    var storyStream: Observable<Story>!

    var leftTitle: Observable<String>!
    var rightImage: Observable<String>!
    var hasMutipleImages: Observable<Bool>!

    init(story: Story) {
        storyStream = Observable.just(story)

        leftTitle = storyStream
            .map { $0.title ?? "没有传title" }

        rightImage = storyStream.map { story -> String in
            if let images = story.images, let image = images.first {
                return image
            } else {
                return ""
            }
        }

        hasMutipleImages = storyStream.map { $0.multipic ?? false }
    }
}
