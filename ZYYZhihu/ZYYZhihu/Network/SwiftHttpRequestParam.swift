//
//  SwiftHttpRequestParam.swift
//  KKTV
//
//  Created by wzh on 2018/3/5.
//

//protocol SwiftHttpRequestCachedCDN {
//    func getUrl() -> String
//}

protocol SwiftHttpRequestEncodedParam {
    var encodedUP: String? {get set}
    var encodedUuid: String? {get set}
    var encodedUnionid: String? {get set}
    
    func getParam() -> String?
}

extension SwiftHttpRequestEncodedParam where Self: CGYJSON {
    func getParam() -> String? {
        guard let jsonModel = self.toJSONModel() else {
            return nil
        }
        
        guard var keyValues = jsonModel as? [String: AnyObject] else {
            return nil
        }
        
        var keys: [String] = []
        for key in keyValues.keys {
            keys.append(key)
        }
        
        let sortedKeys = keys.sorted{$0.caseInsensitiveCompare($1) == .orderedAscending}
        var temp: String = ""
        for key in sortedKeys {
            temp += "\(key):\(keyValues[key]!)"
        }
        
        return nil
        
        // FIXME:- sv 处理 暂时注释掉了
//        if let sv = HttpRequestEncoder.encodeParam(withKey: temp) {
//            keyValues["sv"] = sv as AnyObject
//            return keyValues.toJSONString()
//        } else {
//            return nil
//        }
    }
}

class SwiftHttpRequestParam: CGYJSON {
    let platform = 3
    let a = 1
    var c = 4
    let v = 500
    
    var FuncTag: String = ""
    var userId: Int32?
    var token: String?

    func setIDFAChannelId() {
        let channelId = UserDefaults.standard.integer(forKey: "xxxx")
        if channelId > 0 {
            c = channelId
        }
    }
}



