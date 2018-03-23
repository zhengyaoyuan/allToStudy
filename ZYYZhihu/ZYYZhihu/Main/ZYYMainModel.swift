//
//  ZYYMainModel.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import ObjectMapper

class ZYYStoryModel: Mappable {
    var title: String?
    var ga_prefix: String?
    var type: Int?
    var id: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        ga_prefix <- map["ga_prefix"]
        type <- map["type"]
        id <- map["id"]
    }
}

class ZYYNormalStoryModel: ZYYStoryModel {
    var images: [String]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        images <- map["images"]
    }
}


class ZYYTopStoryModel: ZYYStoryModel {
    var image: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        image <- map["image"]
    }
}

