//
//  CALayerViewController.swift
//  Interview
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {

    //定时旋转需要用到秒针
    var second: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        clockWithCALayer()
        
        //手动调用解决秒针初始旋转角偏移
        self.rotateSecond()
    }
    
    private func calayer() {
        //CA : Core Animation：改变CALayer属性会自带动画效果：隐式动画：animatable标记的属性
//        let calayer = CALayer()
    }
    
    private func clockWithCALayer() {
        //CA : Core Animation：改变CALayer属性会自带动画效果：隐式动画：animatable标记的属性
        let clockLayer = CALayer()
        //设置frame
        clockLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        clockLayer.position = CGPoint(x: self.view.center.x, y: self.view.center.y * 0.7)
        //设置图片contents
        clockLayer.contents = UIImage(named: "clock")?.cgImage
        
        //圆角
        clockLayer.cornerRadius = 100
        clockLayer.masksToBounds = true

        //添加秒针
        let secondLayer = CALayer()
        secondLayer.bounds = CGRect(x: 0, y: 0, width: 2, height: 100)
        secondLayer.position = clockLayer.position
        secondLayer.backgroundColor = UIColor.red.cgColor
        
        //通过锚点改变secondLayer的center位置实现指针与锚点一长一短距离:锚点x,y取值范围是0~1之间
        secondLayer.anchorPoint = CGPoint(x: 0.5, y: 0.8)
        self.second = secondLayer
        //定时器旋转秒针
        let time: Double = 1
//        let timer = Timer(timeInterval: time, target: self, selector: #selector(CALayerViewController.rotateSecond), userInfo: nil, repeats: true)
//        timer.fire()
        //自动加入到运行循环
//        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(CALayerViewController.rotateSecond), userInfo: nil, repeats: true)
        
        //Timer来定时做秒针旋转不太准确：有毫秒误差：用毫秒级别定时器：CADisplayLink：与屏幕刷新频率同步
        let link = CADisplayLink(target: self, selector: #selector(CALayerViewController.rotateSecond))
        //添加到主运行循环中
        link.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        
        //添加到跟layer
        self.view.layer.addSublayer(clockLayer)
        //添加秒针到根layer
        self.view.layer.addSublayer(secondLayer)
    }
    
    //每隔一秒执行一次
    @objc private func rotateSecond() {
        debugPrint("旋转生效")
        //计算每一秒旋转角度
        let rotateAngle = 2 * Double.pi / 60
        //获取当前时间秒数
        //获取当前日期
        let date = NSDate()
        //获取当前日历对象
        let calender = NSCalendar.current
        //通过日历对象直接获取当当前秒数
        let s: Double = Double(calender.component(Calendar.Component.second, from: date as Date))
        //旋转秒针
        //通过设置一个3D动画
//        self.second?.transform = CATransform3DRotate((second?.transform)!, CGFloat(rotateAngle * s), 0, 0, 1)
        self.second?.transform = CATransform3DMakeRotation( CGFloat(rotateAngle * s), 0, 0, 1)
        //通过设置一个平面动画
//        self.second?.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(rotateAngle * s)))
    }
}
