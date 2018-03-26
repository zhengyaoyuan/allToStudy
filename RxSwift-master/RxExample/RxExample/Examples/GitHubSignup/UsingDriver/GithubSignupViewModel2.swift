//
//  GithubSignupViewModel2.swift
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
 
 This uses Driver builder for sequences.
 
 Please note that there is no explicit state, outputs are defined using inputs and dependencies.
 Please note that there is no dispose bag, because no subscription is being made.
*/
class GithubSignupViewModel2 {
    // outputs {
   
    /*
     Driver 有三个作用
     1. 保证在主线程
     2. shareReplay
     3. never fail
     */
    let validatedUsername: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let validatedPasswordRepeated: Driver<ValidationResult>

    // Is signup button enabled
    let signupEnabled: Driver<Bool>

    // Has user signed in
    let signedIn: Driver<Bool>

    // Is signing process in progress
    let signingIn: Driver<Bool>

    // }

    init(
        // 监听 输入的变动
        input: (
            username: Driver<String>,
            password: Driver<String>,
            repeatedPassword: Driver<String>,
            loginTaps: Signal<Void>
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
         
         When using `Driver`, underlying observable sequence elements are shared because
         driver automagically adds "shareReplay(1)" under the hood.
         
             .observeOn(MainScheduler.instance)
             .catchErrorJustReturn(.Failed(message: "Error contacting server"))
         
         ... are squashed into single `.asDriver(onErrorJustReturn: .Failed(message: "Error contacting server"))`
        */

        validatedUsername = input.username
            .flatMapLatest { username in
                return validationService.validateUsername(username)
                    // asDriver Observable<ValidationResult> -> SharedSequence
                    // flatMapLatest 会把 多个信号 拍扁成一个信号 Driver<ValidationResult>
                    // onErrorJustReturn 里面的参数是 element
                    .asDriver(onErrorJustReturn: .failed(message: "Error contacting server"))
            }

        // Driver<String> map之后 只是修改了元素 Driver<ValidationResult>
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }

        // combineLatest 是合并信号
        // 两个信号合并为一个 Driver<ValidationResult>
        // resultSelector 是把信号的元素传递进去
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)

        // 监控 吐出的都是  Bool
        let signingIn = ActivityIndicator()
        // asDriver() 转化为 SharedSequence<DriverSharingStrategy, Bool>
        // 也就是 Driver<Bool> 吗？
        self.signingIn = signingIn.asDriver()

        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        // Signal<Void>
        // withLatestFrom 前者是触发（元素可为空 Void），后者是拿数据的
        // 元素是 一个元组
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in // pair 是信号里的元素 元组
                // 这里用到请求，所以用 flatMapLatest 注意 return Driver
                // 这里的请求是 注册 signup
                return API.signup(pair.username, password: pair.password)
                    .trackActivity(signingIn)
                    .asDriver(onErrorJustReturn: false)
            }
            // Driver<Bool>
            .flatMapLatest { loggedIn -> Driver<Bool> in
                let message = loggedIn ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
                
                // 这里返回了一个弹窗，需要等待用户的交互，所以也要用成 flatMapLatest
                // map 是把元素 Action -> Bool
                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
                    // propagate original value
                    .map { _ in
                        loggedIn
                    }
                    .asDriver(onErrorJustReturn: false)
            }

        // combineLatest 的信号 分别拿信号的最新的值
        // 根据这些最新的值 return 一个元素  Bool
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn
        )   { username, password, repeatPassword, signingIn in
                username.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
            }
            // 值有变化，才会发出信号
            .distinctUntilChanged()
    }
}
