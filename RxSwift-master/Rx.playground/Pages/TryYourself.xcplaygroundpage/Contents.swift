/*:
 > # IMPORTANT: To use **Rx.playground**:
 1. Open **Rx.xcworkspace**.
 1. Build the **RxSwift-macOS** scheme (**Product** → **Build**).
 1. Open **Rx** playground in the **Project navigator**.
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 */
import RxSwift
/*:
 # Try Yourself
 
 It's time to play with Rx 🎉
 */
playgroundShouldContinueIndefinitely()

example("Try yourself") {
  // let disposeBag = DisposeBag()
  _ = Observable.just("Hello, RxSwift!")
    .debug("Observable")
    .subscribe()
    // .disposed(by: disposeBag) // If dispose bag is used instead, sequence will terminate on scope exit
}

example("test shareReplay") {
    let disposeBag = DisposeBag()
    let testReplay = Observable.just("😂")
        .map { print($0)}
        .shareReplay(1)

    testReplay
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)

    testReplay
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
}

example("test shareReplay") {
    let disposeBag = DisposeBag()
    
    let observable = Observable.of(1, 2, 3)
        .map{ print($0) }
        .shareReplay(5)

//        .share(replay: 1)
    
    observable
        .subscribe { print($0) }
        .disposed(by: disposeBag)

    observable
        .subscribe { print($0) }
        .disposed(by: disposeBag)
}

example("test flatMap") {
    let disposeBag = DisposeBag()
    
//    let test = Observable.of(1, 2, 3, 4)
//        .map{ Observable.just($0) }
//        .merge()
    
    let test = Observable.of(1, 2, 3, 4)
        .flatMapLatest{ Observable.just($0) }
    
    
    test.subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}
