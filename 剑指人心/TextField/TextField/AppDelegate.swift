//
//  AppDelegate.swift
//  TextField
//
//  Created by 郑尧元 on 2018/2/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var usernameField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    override func controlTextDidBeginEditing(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            let text = textField.stringValue
            if (textField == usernameField) {
                print("username:\(text)")
            } else if (textField == passwordTextField) {
                print("password:\(text)")
            }
        }
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector ==  #selector(NSResponder.insertNewline(_:)) {
            print("Enter")
            
            return true
        }
        
        return false
    }

}

