//
//  AppDelegate.swift
//  TextView
//
//  Created by 郑尧元 on 2018/2/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextViewDelegate, NSTextStorageDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var textView: NSTextView!
    
    @IBOutlet weak var attributeTextView: NSTextView!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        addAttribute()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func textDidBeginEditing(_ notification: Notification) {
        print("begin editing")
    }
    
    func addAttribute() {
        let attributeString = NSMutableAttributedString(string: "attributedString")
        attributeString.addAttributes([NSAttributedStringKey.foregroundColor: NSColor.blue], range: NSMakeRange(0, 10))
        attributeString.addAttributes([NSAttributedStringKey.foregroundColor: NSColor.red], range: NSMakeRange(10, 6))
        
        attributeTextView.textStorage?.setAttributedString(attributeString)
        attributeTextView.textStorage?.delegate = self
    }
    
    

}

