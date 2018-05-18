//
//  ZYYMainViewController.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/3/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZYYMainViewController: BaseViewController {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var jumpBtn: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 人为代码驱动
//        let subject = PublishSubject<String>()
//        let viewModel = ZYYMainViewModel.init(o: subject.asDriver())
//        subject.onNext("Void")
//        refreshBtn.rx.tap.asSignal().startWith(Void)
        // 由 UI 驱动
        let viewModel = ZYYMainViewModel(refreshTap: refreshBtn.rx.tap.asSignal(), jumpTap: jumpBtn.rx.tap.asSignal())
        
        // 要绑定到 cell 上
        viewModel.stories
            .drive(tableView.rx.items(cellIdentifier: "mainTableViewCell", cellType: ZYYMainTableViewCell.self)) {
            (row, element, cell) in
            cell.configCell(With: element)
        }
            .disposed(by: disposeBag)
        
        // 路由
        viewModel.router
            .drive(onNext: { [unowned self] router in
            router.go(from: self)
        })
            .disposed(by: disposeBag)
        // 有个疑问，vc 与 vc 之间，怎么交流比较好呢？？？
        
        // 临时代码 要删的
        
    }

    

}
