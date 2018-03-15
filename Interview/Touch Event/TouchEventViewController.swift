//
//  TouchEventViewController.swift
//  Interview
//
//  Created by mac on 2018/3/10.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class TouchEventViewController: UIViewController {

    @IBOutlet weak var unlockView: GesturesUnlockView!
    
    //定义一个手势正确密码
    let pass = "012"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //通过UIColor的方法将图片转换为颜色设置
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "Home_refresh_bg")!)
        
        
        //判断密码是否正确
        unlockView.checkPassBlock = { (pass) in
            debugPrint("pass")
            if pass.elementsEqual(self.pass) {
                debugPrint("密码正确")
                //界面跳转到主页
                
                return true
            }else {
                debugPrint("密码错误") 
                return false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        debugPrint("touches  --->  \(touches)")
//
//        debugPrint("event  --->  \(event)")

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        showLightPathWithTouches(touches: touches)
    }

    /**
     *  Desc: 跟随手指一动坐标绘制荧光路线
     *  Param:
     */
    private func showLightPathWithTouches(touches: Set<UITouch>) {
        //获取触摸对象：单点触控
//        let touch = touches.first
        
        //获取UITouch对象：可能又多个：支持多点触控：在UIStoryBoard中勾选Mutiple Touch
        //Set：无序用for in 遍历：手动管理变量i递增
        var i = 0
        for touch in touches {
            //获取荧光图片
            let name = "light_dot_0\(i+1)"
            let lightDot = UIImage(named: name)
            debugPrint("lightDot --> \(lightDot)")
            let iv = UIImageView(image: lightDot)
            iv.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
            iv.center = (touch.location(in: self.view))
            self.view.addSubview(iv)
            
            //开启一个动画：延时1秒后让荧光点消失
            UIView.animate(withDuration: 1, delay: 1, options: .curveLinear, animations: {
                iv.alpha = 0
            }) { (isComplete) in
                if isComplete {
                    iv.removeFromSuperview()
                }
            }
            i = i + 1
        }
        
    }
}
