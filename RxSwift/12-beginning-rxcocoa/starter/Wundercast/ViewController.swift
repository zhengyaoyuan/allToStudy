/*
 * Copyright (c) 2014-2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var searchCityName: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tempSwitch: UISwitch!
    
    
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        style()
        
        // 最重要的地方
        
        // 0
//        ApiController.shared.currentWeather(city: "RxSwfit")
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { data in
//                self.tempLabel.text = "\(data.temperature)° C"
//                self.iconLabel.text = data.icon
//                self.humidityLabel.text = "\(data.humidity)%"
//                self.cityNameLabel.text = data.cityName
//            })
//            .disposed(by: bag)
        
        // 1
//        searchCityName.rx.text
//            .filter { ($0 ?? "").count > 0 }
//            .flatMap { text in
//                return ApiController.shared.currentWeather(city: text ?? "Error")
//                    .catchErrorJustReturn(ApiController.Weather.empty)
//        }
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { data in
//                self.tempLabel.text = "\(data.temperature)° C"
//                self.iconLabel.text = data.icon
//                self.humidityLabel.text = "\(data.humidity)%"
//                self.cityNameLabel.text = data.cityName
//            })
//            .disposed(by: bag)
        
        // 2 bind
//        let search = searchCityName.rx.text
//            .filter { ($0 ?? "").count > 0 }
//            .flatMapLatest { text in
//                return ApiController.shared.currentWeather(city: text ?? "Error")
//                    .catchErrorJustReturn(ApiController.Weather.empty)
//            }
//            .shareReplay(1)
//            .observeOn(MainScheduler.instance)
//
//        search.map { "\($0.temperature)° C" }
//            .bind(to:tempLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { $0.icon }
//            .bind(to:iconLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { "\($0.humidity)%" }
//            .bind(to:humidityLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { $0.cityName }
//            .bind(to:cityNameLabel.rx.text)
//            .disposed(by:bag)
        
        
        // 3 traits
//        let search = searchCityName.rx.text
//            .filter { ($0 ?? "").count > 0 }
//            .flatMapLatest { text in
//                return ApiController.shared.currentWeather(city: text ?? "Error")
//                    .catchErrorJustReturn(ApiController.Weather.empty)
//            }
//            // main thread / avoid error
//            .asDriver(onErrorJustReturn: ApiController.Weather.empty)
//        search.map { "\($0.temperature)° C" }
//            .drive(tempLabel.rx.text)
//            .disposed(by: bag)
//        search.map { $0.icon }
//            .drive(iconLabel.rx.text)
//            .disposed(by: bag)
//        search.map { "\($0.humidity)%" }
//            .drive(humidityLabel.rx.text)
//            .disposed(by: bag)
//        search.map { $0.cityName }
//            .drive(cityNameLabel.rx.text)
//            .disposed(by: bag)
        
        // 4 限制一直搜索，点击搜索按钮才会搜索
//        let search = searchCityName.rx.controlEvent(.editingDidEndOnExit).asObservable()
//            .map { self.searchCityName.text }
//            .filter { ($0 ?? "").count > 0 }
//            .flatMapLatest { text in
//                return ApiController.shared.currentWeather(city: text ?? "Error")
//                    //.catchErrorJustReturn(ApiController.Weather.empty)
//            }
//            .asDriver(onErrorJustReturn: ApiController.Weather.empty)
//
//        search.map { "\($0.temperature)° C" }
//            .drive(tempLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { $0.icon }
//            .drive(iconLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { "\($0.humidity)%" }
//            .drive(humidityLabel.rx.text)
//            .disposed(by:bag)
//
//        search.map { $0.cityName }
//            .drive(cityNameLabel.rx.text)
//            .disposed(by:bag)
        
        // challenge 首先一点是 触发时机多了 有多个序列，需要用合并类型的，第二点 转化的时候 有区别
        let temperatue = tempSwitch.rx.controlEvent(.valueChanged).asObservable()
        let textSearch = searchCityName.rx.controlEvent(.editingDidEndOnExit).asObservable()
        
        let search = Observable.from([temperatue, textSearch])
            .merge()  // 重点
            .map { self.searchCityName.text }
            .filter { ($0 ?? "").count > 0 }
            .flatMapLatest { text in
                return ApiController.shared.currentWeather(city: text ?? "Error")
                //.catchErrorJustReturn(ApiController.Weather.empty)
            }
            .asDriver(onErrorJustReturn: ApiController.Weather.empty)
        
        search.map { w in
            if self.tempSwitch.isOn {
                return "\(Int(Double(w.temperature) * 1.8 + 32))° F"
            } else {
                return "\(w.temperature)° C"
            }
        }
        .drive(self.tempLabel.rx.text)
        .disposed(by: bag)
        
        search.map { $0.icon }
            .drive(iconLabel.rx.text)
            .disposed(by:bag)
        
        search.map { "\($0.humidity)%" }
            .drive(humidityLabel.rx.text)
            .disposed(by:bag)
        
        search.map { $0.cityName }
            .drive(cityNameLabel.rx.text)
            .disposed(by:bag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Appearance.applyBottomLine(to: searchCityName)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Style
    
    private func style() {
        view.backgroundColor = UIColor.aztec
        searchCityName.textColor = UIColor.ufoGreen
        tempLabel.textColor = UIColor.cream
        humidityLabel.textColor = UIColor.cream
        iconLabel.textColor = UIColor.cream
        cityNameLabel.textColor = UIColor.cream
    }
}

