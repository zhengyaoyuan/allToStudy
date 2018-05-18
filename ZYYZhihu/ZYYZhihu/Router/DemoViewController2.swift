//
//  DemoViewController2.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

class DemoViewController2: BaseViewController {

    var customTitle: String
    
    init(customTitle: String) {
        self.customTitle = customTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
