//
//  Tools.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let logDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter
    } ()
}

func customLog<T>(_ message : T,file : String = #file,funcName : String = #function,lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let datestr = DateFormatter.logDateFormatter.string(from: Date())
    print("<\(fileName) : \(lineNum)> func \(funcName)\n\(datestr) \(message) \n--------")
    #endif
}


//func printInDebug(_ items: @autoclosure () -> Any) {
//    #if DEBUG
//    print(items())
//    #endif
//}
