//
//  AppDelegate.swift
//  MacOSXib
//
//  Created by 郑尧元 on 2018/2/26.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var modalWindow: NSWindow!
    
    var sessionCode: NSApplication.ModalSession?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.windowClose(_:)), name: NSWindow.willCloseNotification, object: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func showModalWindow(_ sender: Any) {
        NSApplication.shared.runModal(for: self.modalWindow)
    }
    
    @IBAction func showSessionWindow(_ sender: Any) {
        NSApplication.shared.beginModalSession(for: self.modalWindow)
    }
    
    @objc func windowClose(_ aNotification: Notification) {
        if let sessionCode = sessionCode {
            NSApplication.shared.endModalSession(sessionCode)
            self.sessionCode = nil
        } else {
            NSApplication.shared.stopModal()
        }
    }

}

