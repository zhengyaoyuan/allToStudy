//
//  SimpleTableViewExampleViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController : ViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建 0 到 19 的字符串数组
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        // 将数据源与 cell 绑定
        items
            // cellType 代表 cell 的 具体类
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)

    }

}
