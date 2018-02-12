//
//  ZYYHomeViewController.swift
//  MacOS
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

class ZYYHomeViewController: NSViewController {

    var sessionCode: NSApplication.ModalSession?
    
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        titleLabel.textColor = NSColor.blue
    }
    
    
    @IBAction func pushModalWindow(_ sender: Any) {
        NSApplication.shared.runModal(for: NSWindow())
    }
    
    @IBAction func pushModalSession(_ sender: Any) {
        sessionCode = NSApplication.shared.beginModalSession(for: NSWindow())
        
    }
    
    
    @IBAction func disappearWindow(_ sender: Any) {
        guard let sessionCode = sessionCode else {
            return
        }
        
        NSApplication.shared.endModalSession(sessionCode)
    }
    
}
