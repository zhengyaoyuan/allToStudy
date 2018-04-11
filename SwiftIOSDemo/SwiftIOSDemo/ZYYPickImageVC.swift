//
//  ZYYPickImageVC.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/4/1.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import MobileCoreServices

class ZYYPickImageVC: UIViewController {

    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showImagePickerController(with: 0)
    }

    private func showImagePickerController(with index: Int) {
        let picker = UIImagePickerController()
//        picker.navigationBar.tintColor = UIColor.RGB(0, 122, 255)
        picker.delegate = self;
        
        if index == 0 {
            picker.sourceType = .photoLibrary
            picker.mediaTypes = [kUTTypeImage as String]
        } else if index == 1 {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//                showToastView(String.LS("Camera Not Available"))
                return
            }
            picker.sourceType = .camera
        }
        
        present(picker, animated: true, completion: nil)
    }
}

extension ZYYPickImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
    
        let theImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        btn.adjustsImageWhenHighlighted = false
        btn.setImage(theImage, for: .normal)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

