//
//  ZYYMainTableViewCell.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Kingfisher

class ZYYMainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // model 如何配置 cell
    func configCell(With model: ZYYNormalStoryModel) {
        if let title = model.title {
            titleLabel.text = title
        }
        
        if let images = model.images, images.count > 0 {
            let imageURL = images[0]
            rightImageView.kf.setImage(with: URL.init(string: imageURL))
        }
    }
}
