//
//  GithubSignupViewModel1.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa

/**
This is example where view model is mutable. Some consider this to be MVVM, some consider this to be Presenter,
 or some other name.
 In the end, it doesn't matter.
 
 If you want to take a look at example using "immutable VMs", take a look at `TableViewWithEditingCommands` example.
 
 This uses vanilla rx observable sequences.
 
 Please note that there is no explicit state, outputs are defined using inputs and dependencies.
 Please note that there is no dispose bag, because no subscription is being made.
*/
class GithubSignupViewModel1 {
    // outputs {

    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>

    // Is signup button enabled
    let signupEnabled: Observable<Bool>

    // Has user signed in
    let signedIn: Observable<Bool>

    // Is signing process in progress
    let signingIn: Observable<Bool>

    // }

    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - input: 输入包括用户名、密码、重复密码、点击注册按钮的动作
    ///   - dependency: 网络请求、验证服务、线框图
    init(input: (
            username: Observable<String>,
            password: Observable<String>,
            repeatedPassword: Observable<String>,
            loginTaps: Observable<Void>
        ),
        dependency: (
            API: GitHubAPI,
            validationService: GitHubValidationService,
            wireframe: Wireframe
        )
    ) {
        let API = dependency.API
        let validationService = dependency.validationService
        let wireframe = dependency.wireframe

        /**
         Notice how no subscribe call is being made. 
         Everything is just a definition.

         Pure transformation of input sequences to output sequences.
        */

        // username 检测用到了真正的请求，所以可能有多个请求同时返回，我们只需要取最晚发出的请求就可以了！！
        validatedUsername = input.username
            .flatMapLatest { username in
                // 这里有用到网络请求！！ validateUsername
                return validationService.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "Error contacting server"))
            }
            .share(replay: 1)
        
        // 密码验证，只做了长度的判断，是能够马上给响应的，所以不用 flatMapLatest，明白了么
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }
            .share(replay: 1)
        // 重复密码验证合法性
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
            .share(replay: 1)

        // 只要有一个序列在计算会吐 true，这里指代 是否正在登陆
        let signingIn = ActivityIndicator()
        
        self.signingIn = signingIn.asObservable()

        // 这个信号，是账号和密码信号的混合体
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        // 是否已经登陆，
        // withLatestFrom 只要点击了注册按钮，就会去取 混合体（最新的账号和密码）
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                // 注册，用到了请求，所以用 flatMapLatest
                return API.signup(pair.username, password: pair.password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(false)
                    .trackActivity(signingIn)
            }
            .flatMapLatest { loggedIn -> Observable<Bool> in
                let message = loggedIn ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
                // 用于弹窗 
                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
                    // propagate original value
                    .map { _ in
                        loggedIn
                    }
            }
            .share(replay: 1)
        
        // 是否允许注册要满足四个条件的
        signupEnabled = Observable.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn.asObservable()
        )   { username, password, repeatPassword, signingIn in
                username.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
            }
            .distinctUntilChanged()
            .share(replay: 1)
    }
}
