//
//  DynamicViewController.swift
//  Interview
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {

    var animator:UIDynamicAnimator?
    
    var redView: UIView!
    
    var orangeView: UIView!
    
    //记录redView初始位置
    var redFrame: CGRect!
    
    var currentPoint: CGPoint!
    
    var attachment: UIAttachmentBehavior!
    
    //重新设置View根布局
    override func loadView() {
        self.view = BgView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //创建一个View并添加到布局上
        redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        redView.center = self.view.center
        self.view.addSubview(redView)
        self.redFrame = redView.frame
        
        //创建一个View并添加到布局上
        orangeView = UIView()
        orangeView.backgroundColor = UIColor.orange
        orangeView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        orangeView.center = CGPoint(x: self.view.center.x + 25, y: self.view.bounds.height-15 - 400)
        self.view.addSubview(orangeView)
    }
    //添加重力动画
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        redView.frame = redFrame
        //添加重力场
//        addGravityInView(view: redView)
        //添加碰撞仿真
//        addCollisionInView(view: orangeView)
//        addCollisionInView(view: [redView, orangeView])
        
        //获取坐标点位置
        let p = touches.first?.location(in: self.view)
        self.currentPoint = p
        
        //添加snap（冲击行为）
//        addSnapInView(view: redView)
        
        //添加附着动画
//        addAttachmentInView(view: redView)
        
        //添加推：push动画
        addPushInView(view: [redView])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取坐标点位置
        let p = touches.first?.location(in: self.view)
        self.currentPoint = p
        
//        attachment.anchorPoint = self.currentPoint
    }
    
    /**
     *  Desc: 给指定View添加重力场动画：物理仿真
     *  Param: view ：需要添加到重力场的View
     */
    private func addGravityInView(view: UIView) {
        //创建动画者对象：动画者不能作为局部变量：动画执行过程不能被销毁
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //创建行为
        let gravity = UIGravityBehavior()
        //将需要添加动画的View添加到重力场中：UIView已经遵守了UIDynamic协议
        gravity.addItem(view)
        
        //1.通过angle改变重力方向：0~2*Pi
        //gravity.angle = 0
        //2.通过向量CGVector改变方向:CGVector(dx: 0, dy: 0)表示向右
        //gravity.gravityDirection = CGVector(dx: 0, dy: 0)
        //改变重量级:数值越大重力越大
        gravity.magnitude = 1
        
        //将重力行为添加到动画者上执行
        animator?.addBehavior(gravity)
        
    }
    
    /**
     *  Desc: 给指定View添加碰撞动画：物理仿真
     *  Param: [UIView] ：需要添加碰撞效果的View数组
     */
    private func addCollisionInView(view: [UIView]) {
        //创建动画者对象：动画者不能作为局部变量：动画执行过程不能被销毁
        //引用一个View可以作为边界
//        animator = UIDynamicAnimator(referenceView: self.view)
        
        //创建行为
        let collision = UICollisionBehavior(items: view)
        //将需要添加动画的View添加到重力场中：UIView已经遵守了UIDynamic协议
//        collision.addItem(view)
        //添加碰撞模式：everything表示所有的item及边界都会发生碰撞
        collision.collisionMode = .everything
        
        //绘制自定义边界：不用引用的View作为边界
        //1.通过两个点绘制一条直线作为边界
        let startPoint = CGPoint(x: 0, y: 400)
        let endPoint = CGPoint(x: 200, y: 550)
//        collision.addBoundary(withIdentifier: "boundary" as NSCopying, from: startPoint, to: endPoint)
        
        //2.通过UIBezierPath来绘制一个边界
        let path = UIBezierPath(rect: orangeView.frame)
        collision.addBoundary(withIdentifier: "boundary" as NSCopying, for: path)
        
        //将初始化时引用的View作为碰撞的边界：与边界碰撞💥
        collision.translatesReferenceBoundsIntoBoundary = true
        
        //监听碰撞过程个Item间发生变化：如frame的变化
        collision.action = {
//            debugPrint("监听collision碰撞过程变化---frame == \(self.redView.frame)")
        }
        
        //设置代理监听碰撞
        collision.collisionDelegate = self
        
        //将重力行为添加到动画者上执行
        animator?.addBehavior(collision)
        
    }
    
    /**
     *  Desc: 给指定View添加甩(冲击)动画：物理仿真
     *  Param: UIView ：需要添加甩(冲击)效果的View
     */
    private func addSnapInView(view: UIView) {
        //创建动画者对象：动画者不能作为局部变量：动画执行过程不能被销毁
//        animator = UIDynamicAnimator(referenceView: self.view)
        
        //创建行为
        let snap = UISnapBehavior(item: view, snapTo: self.currentPoint)
        //改变冲击力度：0~1：越大力度越小
        snap.damping = 0
        
        //将重力行为添加到动画者上执行
        animator?.addBehavior(snap)
        
    }
    
    /**
     *  Desc: 给指定View添加附着行为：物理仿真：刚性附着/弹性附着：刚性附着加上控制频率frequency属性即可
     *  Param: UIView ：需要添加附着行为效果的View
     */
    private func addAttachmentInView(view: UIView) {
        //创建动画者对象：动画者不能作为局部变量：动画执行过程不能被销毁
//        animator = UIDynamicAnimator(referenceView: self.view)
        
        //创建行为
//        let attachment = UIAttachmentBehavior(item: view, attachedToAnchor: self.currentPoint)
        //view附着到一个点上
//        attachment = UIAttachmentBehavior(item: view, attachedToAnchor: self.currentPoint)
        //View附着到另一个item上
        //attachment = UIAttachmentBehavior(item: view, attachedTo: orangeView)
        //附着item上设置锚点:UIOffset表示中心点往四个坐标系的x,y值
        let offsetFromCenter = UIOffset(horizontal: -10, vertical: -10)
        let offsetFromCenter1 = UIOffset(horizontal: 10, vertical: 10)
        attachment = UIAttachmentBehavior(item: view, offsetFromCenter: offsetFromCenter, attachedTo: orangeView, offsetFromCenter: offsetFromCenter1)
        //改变振幅：冲击力度：0~1：越大力度越小
        attachment.damping = 0
        //设置附着间距
        //attachment.length = 100
        //弹性附着：加上频率属性即可：0表示刚性附着 1表示弹性附着：但是弹性较强
        attachment.frequency = 1
        //iOS 9.0 frictionTorque：摩擦力
        attachment.frictionTorque = 0.5
        //监听附着过程：强引用循环引用
        attachment.action = { [weak self] in
            //绘制背景连接线
            let view: BgView = self!.view as! BgView
            view.startPoint = self?.redView.center
            view.endPoint = self?.orangeView.center
            view.setNeedsDisplay()
        }
        //将重力行为添加到动画者上执行
        animator?.addBehavior(attachment)
        
    }

    /**
     *  Desc: 给指定View添加push行为：物理仿真
     *  Param: view ：需要添加push行为的View
     */
    private func addPushInView(view: [UIView]) {
        //创建动画者对象：动画者不能作为局部变量：动画执行过程不能被销毁
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //创建行为
        //设置push模式：持续推或者越来越慢
        let push = UIPushBehavior(items: view, mode: .continuous)
        
        //1.通过angle改变重力方向：0~2*Pi
        //push.angle = 0
        //2.通过向量CGVector改变方向:CGVector(dx: 0, dy: 0)表示向右
        push.pushDirection = CGVector(dx: 1, dy: 1)
        //改变重量级:数值越大重力越大
        push.magnitude = 1
        
        //将重力行为添加到动画者上执行
        animator?.addBehavior(push)
        
    }
}

extension DynamicViewController: UICollisionBehaviorDelegate {
    
    //MARK: - UICollisionBehaviorDelegate：绘制有边界而不是引用View的边界才会走代理方法
    //item与边界碰撞时调用
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        
        debugPrint("identifier == \(identifier)")
        
        let key: String = identifier as! String
        
        debugPrint("key == \(key)")
        
        if key == "boundary" {
            //改变item颜色
            self.redView.backgroundColor = getRandomColor()
            self.orangeView.backgroundColor = getRandomColor()
            debugPrint("boundary边界")
        }else if key == nil {
            //nil表示引用View边界
            //改变item颜色
            self.redView.backgroundColor = getRandomColor()
            self.orangeView.backgroundColor = getRandomColor()
            debugPrint("引用View的bounds边界")
        }
    }
    
    private func getRandomColor() -> UIColor{
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
}


