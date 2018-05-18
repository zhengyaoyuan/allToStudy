//
//  CGYJSON.swift
//  JSONExample
//
//  Created by Chakery on 10/22/16.
//  Copyright © 2016 Chakery. All rights reserved.
//

import Foundation

public protocol CGYJSON {
    func toJSONModel() -> AnyObject?
    func toJSONString() -> String?
}

public protocol CGYJSONBasicType: CGYJSON {}

extension CGYJSONBasicType {
    public func toJSONModel() -> AnyObject? {
        return self as AnyObject
    }
}

extension CGYJSON {
    public func toJSONModel() -> AnyObject? {
        var mirror: Mirror? = Mirror(reflecting: self)
        var result: [String: AnyObject] = [:]
        
        guard (mirror != nil) else {
            return result as AnyObject
        }
        
        repeat {
            for case let (label?, value) in mirror!.children {
                if let jsonValue = value as? CGYJSON {
                    let model = jsonValue.toJSONModel()
                    if model is NSNull { continue } // 去掉值为nil的可选类型
                    result[label] = model
                }
            }
            mirror = mirror?.superclassMirror

        } while mirror != nil
        
        return result as AnyObject
    }
    
    public func toJSONString() -> String? {
        guard let jsonModel = self.toJSONModel() else {
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonModel, options: [])
        let str = String(data: data!, encoding: .utf8)
        return str
    }
}

extension Optional: CGYJSON {
    public func toJSONModel() -> AnyObject? {
        if let _self = self {
            if let value = _self as? CGYJSON {
                return value.toJSONModel()
            }
        }
        return NSNull()
    }
}

extension Array: CGYJSON {
    public func toJSONModel() -> AnyObject? {
        var results: [AnyObject] = []
        for item in self {
            if let ele = item as? CGYJSON {
                if let eleModel = ele.toJSONModel() {
                    results.append(eleModel)
                }
            }
        }
        return results as AnyObject
    }
}

extension Dictionary: CGYJSON {
    public func toJSONModel() -> AnyObject? {
        var results: [String: AnyObject] = [:]
        for (key, value) in self {
            if let key = key as? String {
                if let value = value as? CGYJSON {
                    if let valueModel = value.toJSONModel() {
                        results[key] = valueModel
//                        continue
                    }
                } else {
                    results[key] = value as AnyObject
//                    continue
                }
//                results[key] = NSNull()
            }
        }
        return results as AnyObject
    }
}

/*
extension NSDate: CGYJSON {
    public func toJSONModel() -> AnyObject? {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormat.stringFromDate(self)
    }
}
*/

extension String: CGYJSONBasicType {}
extension Int: CGYJSONBasicType {}
extension Int8: CGYJSONBasicType {}
extension Int16: CGYJSONBasicType {}
extension Int32: CGYJSONBasicType {}
extension Int64: CGYJSONBasicType {}
extension UInt: CGYJSONBasicType {}
extension UInt8: CGYJSONBasicType {}
extension UInt16: CGYJSONBasicType {}
extension UInt32: CGYJSONBasicType {}
extension UInt64: CGYJSONBasicType {}
extension Bool: CGYJSONBasicType {}
extension Float: CGYJSONBasicType {}
extension Double: CGYJSONBasicType {}
