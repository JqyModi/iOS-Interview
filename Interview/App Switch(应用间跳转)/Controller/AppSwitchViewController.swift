//
//  AppSwitchViewController.swift
//  Interview
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class AppSwitchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugPrint("点击屏幕跳转到网易彩票应用")
        let shared = UIApplication.shared
        //应用URL需要加上："://"
        let urlS = "Lottery://"
        let url = URL(string: urlS)
        
        if shared.canOpenURL(url!) {
            //加上判断不能通过验证：PS：原因是需要在info.plist中配置一个Key：
            /*//------------------
            <key>LSApplicationQueriesSchemes</key>
            <array>
            <string>tel</string>
            </array>
            //------------------
            */
            shared.open(url!, options: [:], completionHandler: { (isFinished) in
                if isFinished {
                    debugPrint("跳转完成")
                }
            })
        }
    }

}
