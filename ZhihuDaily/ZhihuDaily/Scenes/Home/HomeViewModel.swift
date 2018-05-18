//
//  HomeViewModel.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol HomeViewModelInput {

}

protocol HomeViewModelOutput {
    var stories: Observable<[Story]>! { get }

    var isRefreshing: Observable<Bool>! { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
    func createHomeViewCellModel(for story: Story) -> HomeViewCellModel
}


class HomeViewModel: HomeViewModelType,
                     HomeViewModelInput,
                     HomeViewModelOutput {

    // MARK: Inputs & Outputs
    var inputs: HomeViewModelInput { return self }
    var outputs: HomeViewModelOutput { return self }

    // MARK: Input

    // MARK: Output
    var stories: Observable<[Story]>!

    var isRefreshing: Observable<Bool>!

    func createHomeViewCellModel(for story: Story) -> HomeViewCellModel {
        return HomeViewCellModel(story: story)
    }

    // MARK: Private
    private let service: StoryServiceType
    private let sceneCoordinator: SceneCoordinatorType
    private let refreshProperty = BehaviorSubject<Bool>(value: true)

    // MARK: Init
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared,
         service: StoryService = StoryService()) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service

        var storyArray = [Story]([])


        isRefreshing = refreshProperty.asObservable()

        let requestFirst = isRefreshing.flatMapLatest { isRefreshing -> Observable<NewAndTopStory> in
            guard isRefreshing else { return .empty() }

            return service.latestStories()
        }
            // 调用时机是？？
            .do(onNext: { _ in
                storyArray = []
            })


        stories = requestFirst.map { [unowned self] newAndTopStory -> [Story] in

            newAndTopStory.stories?.forEach { story in
                storyArray.append(story)
            }

            self.refreshProperty.onNext(false)
            return storyArray
        }

    }
    
}
