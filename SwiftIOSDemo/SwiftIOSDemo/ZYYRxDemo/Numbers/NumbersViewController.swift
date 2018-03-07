//
//  NumbersViewController.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/3/7.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {

    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    var disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable
            .combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
