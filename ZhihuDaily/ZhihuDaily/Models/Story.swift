//
//  Story.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: Class
//class StoryModel: Mappable {
//    var title: String?
//    var ga_prefix: String?
//    var type: Int?
//    var id: Int?
//
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        title <- map["title"]
//        ga_prefix <- map["ga_prefix"]
//        type <- map["type"]
//        id <- map["id"]
//    }
//}
//
//class Story: StoryModel {
//    var images: [String]?
//
//    required init?(map: Map) {
//        super.init(map: map)
//    }
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//
//        images <- map["images"]
//    }
//}
//
//
//class TopStory: StoryModel {
//    var image: String?
//
//    required init?(map: Map) {
//        super.init(map: map)
//    }
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//
//        image <- map["image"]
//    }
//}
//
//
//class LatestStory: Mappable {
//    var date: String?
//    var stories: [Story]?
//    var top_stories: [TopStory]?
//
//    required init?(map: Map) {
//    }
//
//    func mapping(map: Map) {
//        date <- map["date"]
//        stories <- map["stories"]
//        top_stories <- map["top_stories"]
//    }
//}

// MARK: struct
protocol StoryType {

    var title: String? { get set }
    var ga_prefix: String? { get set }
    var type: Int? { get set }
    var id: Int? { get set }
}

struct Story: Codable, StoryType {
    var title: String?

    var ga_prefix: String?

    var type: Int?

    var id: Int?

    var multipic: Bool?

    var hasRead = false



//    let title: String?
//    let ga_prefix: String?
//    let type: Int?
//    let id: Int?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case ga_prefix
        case type
        case id
        case images
        case multipic
    }
}


struct TopStory: Codable, StoryType {
    var title: String?

    var ga_prefix: String?

    var type: Int?

    var id: Int?

//    let title: String?
//    let ga_prefix: String?
//    let type: Int?
//    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case title
        case ga_prefix
        case type
        case id
        case image
    }
}


struct NewAndTopStory: Codable {
    let date: String?
    let stories: [Story]?
    let top_stories: [TopStory]?

    enum CodingKeys: String, CodingKey {
        case date
        case stories
        case top_stories
    }
}
