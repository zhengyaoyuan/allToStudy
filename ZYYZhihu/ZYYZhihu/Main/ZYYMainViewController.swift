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

class ZYYMainViewController: UIViewController {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 人为代码驱动
//        let subject = PublishSubject<String>()
//        let viewModel = ZYYMainViewModel.init(o: subject.asDriver())
//        subject.onNext("Void")
        
        // 由 UI 驱动
        let viewModel = ZYYMainViewModel(refreshTap: refreshBtn.rx.tap.asSignal())
        
        // 要绑定到 cell 上
        viewModel.stories
            .drive(tableView.rx.items(cellIdentifier: "mainTableViewCell", cellType: ZYYMainTableViewCell.self)) {
            (row, element, cell) in
            cell.configCell(With: element)
        }
            .disposed(by: disposeBag)
        
    }

    

}
