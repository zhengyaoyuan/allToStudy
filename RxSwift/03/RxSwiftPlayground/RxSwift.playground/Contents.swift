//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    
    // e
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { (string) in
        print(string)
    })
    
    subject.onNext("1")
    
    let subscriptionTwo = subject.subscribe({ (event) in
        print("2)", event.element ?? event)
    })
    
    subject.onNext("3")
    
    subscriptionOne.dispose()
    
    subject.onNext("4")
}

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "Inital value")
    
    let disposeBag = DisposeBag()
    
    subject.onNext("X")
    
    subject
        .subscribe({
        print(label: "1)", event: $0)
    })
        .disposed(by: disposeBag)
    
    subject.onError(MyError.anError)
}

example(of: "ReplaySubject") {
    // 1
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    // 2
    subject.onNext("1")
//    subject.onNext("2")
//    subject.onNext("3")
    // 3
    subject
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)
    
    subject.onNext("4")
    
    subject.onError(MyError.anError)

    subject
        .subscribe {
            print(label: "3)", event: $0)
        }
        .disposed(by: disposeBag)
}

example(of: "Variable") {
    var variable = Variable("Inital Value")
    
    let disposeBag = DisposeBag()
    
    variable.value = "New Inital value"
    
    variable.asObservable()
        .subscribe({
        print(label: "1)", event: $0)
    })
        .disposed(by: disposeBag)
    
    
}


/*:
 Copyright (c) 2014-2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
