//
//  ZYYRequestViewController.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import SnapKit
import Kingfisher

class ZYYActivity: Mappable, CustomStringConvertible {
    var activityDesc: String?
    var activityTitle: String?
    var activityURL: String?
    var imgURL: String?
    
    required init?(map: Map) {
        // Could check json
    }
    
    func mapping(map: Map) {
        activityDesc <- map["activityDesc"]
        activityTitle <- map["activityTitle"]
        activityURL <- map["activityURL"]
        imgURL <- map["imgURL"]
    }
    
    var description:String {
        if let activityDesc = activityDesc, let activityTitle = activityTitle  {
            return "ZYYActivity"+"activityDesc: \(activityDesc)" + "activityTitle: \(activityTitle)"
            
        }
        return ""
    }
}

class ZYYRequestViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moyaRequest()
        
        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createView() {
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        view.addSubview(blueView)
        
        blueView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(blueView.snp.top)
            make.centerX.equalTo(blueView)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
//        let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519634329745&di=d064d173a6db6a36fcdfc7e5bc536fcb&imgtype=0&src=http%3A%2F%2Fweixin.hnedu.cn%2Fupload%2Fresources%2Fimage%2F2015%2F10%2F20%2F31379_500x500.jpg")
//        imageView.kf.setImage(with: url)
        
        imageView.image = R.image.kkbg()
    }
    
    func moyaRequest() {
        ApiManagerProvider.request(.getActivityList(isTop: 1)) { result in
            switch result  {
            case let .success(moyaResponse):
                if let data = try? moyaResponse.mapJSON() as! [String: Any], let list = Mapper<ZYYActivity>().mapArray(JSONObject: data["activityList"]){
                    
                    print(list)
                }
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
            case let .failure(error):
                print(error)
                break
            }
        }
        
    }

}
