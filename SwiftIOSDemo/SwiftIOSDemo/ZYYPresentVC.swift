//
//  ZYYPresentVC.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/4/2.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import SnapKit

class ZYYPresentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        _initNavigationBar()
    }
    
    private func _initNavigationBar() {
        let navigationBar = UIView()
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalToSuperview()
            }
        }
        
        let backButton = UIButton(type: .custom)
        navigationBar.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 10, height: 18))
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.addTarget(self, action: #selector(onBtnBack), for: .touchUpInside)
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "二维码/条形码"
        navigationBar.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func onBtnBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
