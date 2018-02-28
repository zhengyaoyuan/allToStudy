//
//  ViewController.swift
//  TableView
//
//  Created by 郑尧元 on 2018/2/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource {

    let strings = ["apple", "banana", "orange"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: DataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return strings[row]
    }
}

