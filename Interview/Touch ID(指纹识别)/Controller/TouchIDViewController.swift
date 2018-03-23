//
//  TouchIDViewController.swift
//  Interview
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
//1.导入库文件:本地验证
import LocalAuthentication

class TouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //开启指纹识别
        openTouchID()
    }

    private func openTouchID() {
        //2.获取上下文
        let laContext = LAContext()
        //判断是否有指纹识别功能可用
        var error: NSError? = NSError()
        if laContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) {
            debugPrint("可用")
            //开启指纹验证
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "请验证指纹 ~ ", reply: { (isFinished, error) in
                if isFinished {
                    debugPrint("验证成功 ~")
                    //弹框提示时需要在主线程：异步操作
                    
                }
                
                //通过错误代码或者错误提示文字进行进行相对应操作
                if (error != nil) {
                    debugPrint("验证失败")
                }
            })
        }else {
            debugPrint("不可用")
        }
        
        
    }
    
}
