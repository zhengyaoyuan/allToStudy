//
//  ZYYRequestViewController.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Moya




class ZYYRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moyaRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func moyaRequest() {
        ApiManagerProvider.request(.getActivityList(isTop: 1)) { (result) -> () in
//            case let .success(response):
//            break
//            case let .failure(error):
//            break
        }
        
    }

}
