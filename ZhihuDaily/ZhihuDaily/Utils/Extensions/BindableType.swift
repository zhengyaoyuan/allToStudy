//
//  BindableType.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

protocol BindableType {
    // 为协议中某个类型，加一个别名 占位符
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {

    mutating func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UITableViewCell {

    mutating func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}

extension BindableType where Self: UICollectionViewCell {
    
    mutating func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
