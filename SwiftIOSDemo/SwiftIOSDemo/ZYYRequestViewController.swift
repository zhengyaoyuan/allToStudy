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
        ApiManagerProvider.request(.getActivityList(isTop: 1)) { result in
            switch result  {
            case let .success(moyaResponse):
//                let data = moyaResponse.data // Data, your JSON response is probably in here!
                
                let data = try? moyaResponse.mapJSON()
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
            case let .failure(error):
                break
            }
        }
        
    }

}
