//
//  ZYYMainTableViewCell.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

class ZYYMainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
