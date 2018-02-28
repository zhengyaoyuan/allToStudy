//
//  CustomView.swift
//  MacOSXib
//
//  Created by 郑尧元 on 2018/2/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

final class CustomView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
                
        configLayer()
        createView()
    }
    
//    override var isFlipped: Bool {
//        return true
//    }
    
    func createView() {
        let view = NSView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        self.addSubview(view)
    }
    
    func configLayer() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.blue.cgColor
        self.layer?.borderWidth = 2
        self.layer?.cornerRadius = 10
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = self.convert(event.locationInWindow, to: nil)
        NSLog("window point \(event.locationInWindow)")
        NSLog("view point \(point)")
    }
    
    lazy var effectView: NSVisualEffectView = {
        let effectView = NSVisualEffectView()
        effectView.wantsLayer = true
        effectView.material = .light
        effectView.state = .followsWindowActiveState
        effectView.blendingMode = .withinWindow
        
        return effectView
    }()
    
}
