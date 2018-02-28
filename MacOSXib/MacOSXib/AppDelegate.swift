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
        
        setWindowTitleImage()
        window.backgroundColor = NSColor.green
        
        addButtonToTitleBar()
        
        // clear memory
        window.isRestorable = false
        
        window.center()
        
        addScrollView()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    
    @IBAction func showModalWindow(_ sender: Any) {
        NSApplication.shared.runModal(for: self.modalWindow)
    }
    
    @IBAction func showSessionWindow(_ sender: Any) {
        sessionCode = NSApplication.shared.beginModalSession(for: self.modalWindow)
    }
    
    @objc func windowClose(_ aNotification: Notification) {
        if let sessionCode = sessionCode {
            NSApplication.shared.endModalSession(sessionCode)
            self.sessionCode = nil
        } else {
            NSApplication.shared.stopModal()
        }
    }
    
    var myWindow: NSWindow!
    func createWindow() {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style: NSWindow.StyleMask = [NSWindow.StyleMask.titled, NSWindow.StyleMask.closable, NSWindow.StyleMask.resizable]
        
        // Create
        myWindow = NSWindow(contentRect: frame, styleMask: style, backing: .buffered, defer: false)
        myWindow.title = "New Create Window"
        // show
        myWindow.makeKeyAndOrderFront(self)
        // center
        myWindow.center()
    }
    
    func setWindowTitleImage() {
        window.representedURL = URL(string: "WindowTitle")
        window.title = "My Window"
        let image = NSImage(named: NSImage.Name(rawValue: "AppIcon.png"))
        window.standardWindowButton(.documentIconButton)?.image = image
    }
    
    func addButtonToTitleBar() {
        let titleView = window.standardWindowButton(.closeButton)?.superview
        let button = NSButton()
        let x = (window.contentView?.frame.size.width)! - 100
//        let y = (window.contentView!.frame.size.width) - 100
        let frame = CGRect(x: x, y: 0, width: 80, height: 24)
        button.frame = frame
        button.title = "Register"
        button.bezelStyle = .rounded
        titleView?.addSubview(button)
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        window.makeKeyAndOrderFront(self)
        return true
    }
    
    func registerNotification() {
        
    }
    
    func addScrollView() {
        let image = NSImage(named: NSImage.Name(rawValue: "screen.png"))
        let imageViewFrame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        let imageView = NSImageView(frame: imageViewFrame)
        imageView.image = image
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let myScrollView = NSScrollView(frame: frame)
        myScrollView.hasVerticalScroller = true
        myScrollView.hasHorizontalScroller = true
        myScrollView.documentView = imageView
        self.window.contentView?.addSubview(myScrollView)
        
        // scroll to top
        var newScrollOrigin: NSPoint
        let contentView = myScrollView.contentView
        if self.window.contentView!.isFlipped {
            newScrollOrigin = NSPoint(x: 0.0, y: 0.0)
        } else {
            newScrollOrigin = NSPoint(x: 0.0, y: imageView.frame.size.height - contentView.frame.size.height)
        }
        
        contentView.scroll(to: newScrollOrigin)
    }

}

