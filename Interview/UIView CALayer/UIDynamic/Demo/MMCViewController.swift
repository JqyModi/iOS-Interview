//
//  MMCViewController.swift
//  Interview
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class MMCViewController: UIViewController {

    //定义一个数组存放新建的毛毛虫View方便后面的操作
    var views: [UIView]?
    
    //定义物理仿真动画执行者
    lazy var animator: UIDynamicAnimator? = {
        let animate = UIDynamicAnimator(referenceView: self.view)
        return animate
    }()
    
    var attachment: UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }

    private func initView() {
        //初始化九个View作为毛毛虫
        views = [UIView]()
        for i in (0..<9) {
            var w = 30
            var h = w
            let x = i * w + 30
            var y = 200
            let view = UIView()
            
            //最后一个View加大作为头
            if i == 8 {
                w = 60
                h = w
                y = y - w/4
            }
            //设置大小及位置
            view.frame = CGRect(x: x, y: y, width: w, height: h)
            //设置背景色
            view.backgroundColor = getColor()
            
            //圆角处理
            view.layer.cornerRadius = CGFloat(w / 2)
            view.layer.masksToBounds = true
            
            //添加到界面
            self.view.addSubview(view)
            //添加到数组
            views?.append(view)
        }
        
        //添加重力效果
        let gravity = UIGravityBehavior(items: self.views!)
        //添加到动画执行者上
        animator?.addBehavior(gravity)
        
        //添加碰撞效果
        let collision = UICollisionBehavior(items: self.views!)
        //设置当前View作为边界View:碰撞动画才有边界
        collision.translatesReferenceBoundsIntoBoundary = true
        //添加到执行者
        animator?.addBehavior(collision)
        
        //给所有小球View添加附着动画
        for i in (0..<(views?.count)!-1) {
            //创建小球间附着动画
            let attchment1 = UIAttachmentBehavior(item: views![i], attachedTo: views![i+1])
            //将所有小球间附着动画添加到执行者上
            animator?.addBehavior(attchment1)
        }
        
        
        //添加拖拽手势效果
        //1.创建拖拽手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MMCViewController.lastViewDidPan(gesture:)))
        //2.添加手势到View上
        self.views?.last?.addGestureRecognizer(pan)
    }
    
    @objc private func lastViewDidPan(gesture: UIPanGestureRecognizer) {
        debugPrint("gesture --------> \(gesture)")
        //获取当前触摸点坐标
        let p = gesture.location(in: self.view)
        //添加当前触摸点与lastView的附着效果:改变原来创建的附着动画只改变附着点即可不是重新创建
        if attachment == nil {
            attachment = UIAttachmentBehavior(item: (self.views?.last)!, attachedToAnchor: p)
        }
        attachment?.anchorPoint = p
        //添加到动画执行者
        animator?.addBehavior(attachment!)
        
        //判断当前拖拽状态：如果是拖拽结束就取消附着效果
        if gesture.state == UIGestureRecognizerState.ended {
            animator?.removeBehavior(attachment!)
        }
    }
    
    private func getColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
    
}
