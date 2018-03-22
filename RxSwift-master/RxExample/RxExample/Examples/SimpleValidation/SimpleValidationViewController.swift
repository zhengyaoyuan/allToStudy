//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class SimpleValidationViewController : ViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!

    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    func bindUIZYY() {
        
        usernameValidOutlet.text = "字符必须不少于\(minimalUsernameLength)"
        passwordValidOutlet.text = "字符必须不少于\(minimalPasswordLength)"
        
        // 1 用户名是否合法 转
        // 注意：usernameOutlet.rx.text.orEmpty 就是一个 Observable
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength}
            .share(replay: 1)
        // 2 密码是否合法
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        // 3 前两者组合，&& 是否合法
        let bothValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        // 4 用户名下的提示语的 isHidden 与 1 绑定
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        // 5 password  isEnable 与 1 绑定
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        // 6 密码下提示语  isHidden 与 2 绑定
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        // 7 按钮的 isEnable 与 3 绑定
        bothValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        // 8 按钮的点击事件的获取 直接订阅了，没有涉及到 bind
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUIZYY()
//        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
//        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
//
//        let usernameValid = usernameOutlet.rx.text.orEmpty
//            .map { $0.count >= minimalUsernameLength }
//            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default
//
//        let passwordValid = passwordOutlet.rx.text.orEmpty
//            .map { $0.count >= minimalPasswordLength }
//            .share(replay: 1)
//
//        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
//            .share(replay: 1)
//
//        usernameValid
//            .bind(to: passwordOutlet.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        usernameValid
//            .bind(to: usernameValidOutlet.rx.isHidden)
//            .disposed(by: disposeBag)
//
//        passwordValid
//            .bind(to: passwordValidOutlet.rx.isHidden)
//            .disposed(by: disposeBag)
//
//        everythingValid
//            .bind(to: doSomethingOutlet.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        doSomethingOutlet.rx.tap
//            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
//            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alertView.show()
    }
}
