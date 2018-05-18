//
//  BaseViewController.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- Pop View
    func showToast(_ text: String) {
        ToastView.hide(in: view)
        let _ = ToastView.show(in: view, text: text)
    }
    
    func showLoadingView(_ text: String? = nil) {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func showNoticeView() -> UIView {
        return UIView()
    }

    
    // MARK:- deinit
    deinit {
        customLog(String(describing: type(of: self)) + " deinit")
//        printInDebug(String(describing: type(of: self)) + " deinit")
    }

}
