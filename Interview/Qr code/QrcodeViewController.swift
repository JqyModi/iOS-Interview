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

    override func viewDidLoad() {
        super.viewDidLoad()
        getQrcode()
    }

    private func getQrcode() {
        let avDivice = AVCaptureDevice(uniqueID: UUID.init().uuidString)
        let avInput = AVCaptureSession()
    }
    
}
