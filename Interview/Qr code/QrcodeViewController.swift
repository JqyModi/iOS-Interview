//
//  QrcodeViewController.swift
//  Interview
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import AVFoundation

class QrcodeViewController: UIViewController {

    //引用
    var session: AVCaptureSession?
    var layer: CALayer?
    var preView: PreView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 0.93)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        getQrcode()
    }

    private func getQrcode() {
        //获取输入设备
        let avDivice = AVCaptureDevice.default(for: AVMediaType.video)
        var avInput: AVCaptureDeviceInput?
        do {
            //获取输入流
            avInput = try AVCaptureDeviceInput(device: avDivice!)
        }catch {
            debugPrint(error)
        }
        //获取输出流
        let avOutput = AVCaptureMetadataOutput()
        
        //创建会话
        let session = AVCaptureSession()
        self.session = session
        
        //设置session的扫描展示大小
        self.session?.sessionPreset = .high
        
        //将输入流与输出流与会话关联
        if session.canAddInput(avInput!) {
            session.addInput(avInput!)
        }
        if session.canAddOutput(avOutput) {
            session.addOutput(avOutput)
        }
        //需要绑定输入输出流到会话上再设置否则崩溃：Unsupported type found - use -availableMetadataObjectTypes
        //设置输出流代理事件
        avOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //设置源数据类型：二维码
        avOutput.metadataObjectTypes = [.qr]
        
        //获取预览layer
//        self.layer = AVCaptureVideoPreviewLayer(session: session)
//        //设置layer的大小
//        self.layer?.frame = UIScreen.main.bounds
//        //添加到View上
//        self.view.layer.addSublayer(layer!)
        
        //用自定义的preView代替layer
        self.preView = PreView(frame: self.view.bounds)
        //绑定会话
        self.preView?.session = self.session
        self.view.addSubview(preView!)
        //开始回话
        session.startRunning()
    }
    
}
extension QrcodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //获取到扫描信息：
        //1.停止扫描
        self.session?.stopRunning()
        //2.移除预览的layer
        self.layer?.removeFromSuperlayer()
        //3.解析数据
        debugPrint("metadataObjects ---> \(metadataObjects.description)")
    }
}
