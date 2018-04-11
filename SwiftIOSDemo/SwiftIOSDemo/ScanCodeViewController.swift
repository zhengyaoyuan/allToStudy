//
//  ScanQRViewController.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/3/30.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0//扫描时长

class ScanCodeViewController: UIViewController
{
    
    //MARK: -
    //MARK: Global Variables
    
    var scanPane: UIImageView!///扫描框
    
    //MARK: -
    //MARK: Lazy Components
    
    // 扫描 会跑的线
    lazy var scanLine : UIView =
        {
            
            let scanLine = UIView()
            scanLine.frame = CGRect(x: 0, y: 0, width: self.scanPane.bounds.width, height: 3)
            scanLine.backgroundColor = UIColor.white
            //            scanLine.image = UIImage(named: "QRCode_ScanLine")
            
            return scanLine
            
    }()
    
    
    var scanSession :  AVCaptureSession?
    
    
    //MARK: -
    //MARK: Public Methods
    
    
    //MARK: -
    //MARK: Data Initialize
    
    
    //MARK: -
    //MARK: Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 初始化 view
        initSubViews()
        // setup session
        setupScanSession()
        
        startScan()
    }
    
    private func initSubViews() {
        self.title = "二维码/条形码"
        
        scanPane = UIImageView.init(image: UIImage.init(named: "QRCode_ScanBox"))
        
        self.view.addSubview(scanPane)
        scanPane.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(142)
            make.size.equalTo(CGSize(width: 266, height: 266))
            make.centerX.equalToSuperview()
        }
        
        view.layoutIfNeeded()
        scanPane.addSubview(scanLine)
        
        let label = UILabel()
        label.text = "将二维码条/形码放入框内,即可自动扫码"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 11.0
        label.layer.masksToBounds = true
        
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 240, height: 22))
            make.top.equalTo(scanPane.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
        
        // 扣出中间透明的效果
        let path = UIBezierPath(rect: self.view.frame)
        let innerPath = UIBezierPath(rect: scanPane.frame)
        path.append(innerPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.34
        self.view.layer.addSublayer(fillLayer)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    
    func setupScanSession()
    {
        if let device = AVCaptureDevice.default(for: .video) {
            do
            {
                //设置捕捉设备
//                let device = AVCaptureDevice.default(for: .video)
                
                //            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
                //设置设备输入输出
                let input = try AVCaptureDeviceInput(device: device)
                
                let output = AVCaptureMetadataOutput()
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                //设置会话
                let  scanSession = AVCaptureSession()
                scanSession.canSetSessionPreset(AVCaptureSession.Preset.high)
                
                if scanSession.canAddInput(input)
                {
                    scanSession.addInput(input)
                }
                
                if scanSession.canAddOutput(output)
                {
                    scanSession.addOutput(output)
                }
                
                //设置扫描类型(二维码和条形码)
                output.metadataObjectTypes = [
                    AVMetadataObject.ObjectType.qr,
                    AVMetadataObject.ObjectType.code39,
                    AVMetadataObject.ObjectType.code128,
                    AVMetadataObject.ObjectType.code39Mod43,
                    AVMetadataObject.ObjectType.ean13,
                    AVMetadataObject.ObjectType.ean8,
                    AVMetadataObject.ObjectType.code93]
                
                //预览图层
                let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
                scanPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                scanPreviewLayer.frame = view.layer.bounds
                
                view.layer.insertSublayer(scanPreviewLayer, at: 0)
                
                //设置扫描区域
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                    output.rectOfInterest = (scanPreviewLayer.metadataOutputRectConverted(fromLayerRect: self.scanPane.frame))
                })
                
                //保存会话
                self.scanSession = scanSession
                
            }
            catch
            {
                //摄像头不可用
                print("不可用")
                //            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
                
                return
            }
        }
        
        
    }
    
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    //开始扫描
    fileprivate func startScan()
    {
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
        
        
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation
    {
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    //MARK: -
    //MARK: Dealloc
    
    deinit
    {
        ///移除通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
}


//MARK: -
//MARK: AVCaptureMetadataOutputObjects Delegate

//扫描捕捉完成
extension ScanCodeViewController : AVCaptureMetadataOutputObjectsDelegate
{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        
        //停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //播放声音
//        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        //扫完完成
        if metadataObjects.count > 0
        {
            
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                print("扫描结果：\(String(describing: resultObj.stringValue))")
//                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self,handler: { (_) in
                    //继续扫描
//                    self.startScan()
//                })
                
            }
            
        }
        
    }
    
}


