//
//  ViewController.swift
//  CollectionView
//
//  Created by 郑尧元 on 2018/2/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LabelCollectionViewItem"), for: indexPath)
        
        return  item
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

