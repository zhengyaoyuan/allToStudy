//
//  HomeViewCell.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/11.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift
import Nuke

class HomeViewCell: UITableViewCell, BindableType {

    // MARK: ViewModel
    var viewModel: HomeViewCellModelType!

    // MARK: IBOutlets
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var multipleImageTipLabel: UILabel!

    // MARK: Private
    private static let nukeManager = Nuke.Manager.shared
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        rightImageView.image = nil
    }

    // MARK: BindableType

    func bindViewModel() {
//        let inputs = viewModel.inputs
        let outputs = viewModel.outputs

        outputs.leftTitle
            .bind(to: leftLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.rightImage
            .flatMap { HomeViewCell.nukeManager.loadImage(with: $0).orEmpty }
            .bind(to: rightImageView.rx.image)
            .disposed(by: disposeBag)

        outputs.hasMutipleImages
            .map { !$0 }
            .bind(to: multipleImageTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
