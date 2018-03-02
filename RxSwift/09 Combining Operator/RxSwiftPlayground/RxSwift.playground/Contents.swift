//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift

example(of: "startWith") {
    // 1
    let numbers = Observable.of(2, 3, 4)
    // 2
    let observable = numbers.startWith(1)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "Observable.concat") {
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    
    let observable = Observable.concat([second, first])
    
    observable.subscribe(onNext: {
        print($0)
    })
}

example(of: "concat") {
    let germanCities = Observable.of("Berlin", "Münich", "Frankfurt")
    let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")
    let observable = germanCities.concat(spanishCities)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "merge") {
    // 1
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    // 2
    let source = Observable.of(left.asObservable(), right.asObservable())
    // 3
    let observable = source.merge()
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    // 4
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]
    repeat {
        if arc4random_uniform(2) == 0 {
            if !leftValues.isEmpty {
                left.onNext("Left:  " + leftValues.removeFirst())
            }
        } else if !rightValues.isEmpty {
            right.onNext("Right: " + rightValues.removeFirst())
        }
    } while !leftValues.isEmpty || !rightValues.isEmpty
    // 5
    disposable.dispose()
}

example(of: "combineLatest") {
    
}

example(of: "combine user choice and value") {
    let choice : Observable<DateFormatter.Style> =
        Observable.of(.short, .long)
    let dates = Observable.of(Date())
    let observable = Observable.combineLatest(choice, dates) {
        (format, when) -> String in
        let formatter = DateFormatter()
        formatter.dateStyle = format
        return formatter.string(from: when)
    }
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "withLatestFrom") {
    // 1
    let button = PublishSubject<String>()
    let textField = PublishSubject<String>()
    // 2
    let observable = button.withLatestFrom(textField)
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    // 3
    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")
    button.onNext("")
    button.onNext("")
}

example(of: "amb") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    // 1
    let observable = left.amb(right)
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    // 2
    left.onNext("Lisbon")
    right.onNext("Copenhagen")
    left.onNext("London")
    left.onNext("Madrid")
    right.onNext("Vienna")
    disposable.dispose()
}

example(of: "reduce") {
    let source = Observable.of(1, 3, 5, 7, 9)
    // 1
    let observable = source.reduce(0, accumulator: +)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "scan") {
    let source = Observable.of(1, 3, 5, 7, 9)
    let observable = source.scan(0, accumulator: +)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "shareReplay") {
    let bag = DisposeBag()
    
    // 订阅一次， map 就执行一次
    let testReplay = Observable.just("😂")
        .map {  print($0) }
        .shareReplay(1)
    
    testReplay
        .subscribe { event in
            print(event)
        }
        .disposed(by: bag)
    
    testReplay
        .subscribe { event in
            print(event)
        }
        .disposed(by: bag)
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
