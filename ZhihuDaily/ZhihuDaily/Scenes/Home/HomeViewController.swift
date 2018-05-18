//
//  HomeViewController.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/11.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

typealias HomeSectionModel = SectionModel<String, Story>

class HomeViewController: UIViewController, BindableType {

    // MARK: ViewModel
    var viewModel: HomeViewModelType!

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Private
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<HomeSectionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
    }

    // MARK: BindableType
    func bindViewModel() {

//        let inputs = viewModel.inputs
        let outputs = viewModel.outputs

        dataSource = RxTableViewSectionedReloadDataSource<HomeSectionModel>(
            configureCell:  tableViewDataSource
        )

        outputs.stories
            // 啥意思来着？
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }

    // MARK: UI

    private func configureNavigationBar() {

        navigationController?.setNavigationBarHidden(true, animated: false)

        title = "今日热闻"
        // iOS 11 写法
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    private func configureTableView() {
        tableView.registerCell(type: HomeViewCell.self)
//        tableView.rx.itemSelected.sub
    }


    var tableViewDataSource: TableViewSectionedDataSource<HomeSectionModel>.ConfigureCell {
        return { [unowned self] _, tv, ip, i in
            var cell = tv.dequeueResuableCell(type: HomeViewCell.self, forIndexPath: ip)
            // 连 cell 都绑定了 viewModel 由页面的 vm 创建 cell 的 vm
            cell.bind(to: self.viewModel.createHomeViewCellModel(for: i))
            return cell
        }
    }

}
