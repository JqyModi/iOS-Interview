//
//  CALayerViewController.swift
//  Interview
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {

    @IBOutlet weak var pageImageView: UIImageView!
    
    let pageCount = 5
    //存放Image
    lazy var images: [UIImage] = {
        var images = NSMutableArray()
        for i in (0..<5) {
            let image = UIImage(named: "\(i+1)")
            images.add(image)
        }
        return images as! [UIImage]
    }()
    
    //记录图片名字：默认以数组命名1，2，3...
    var imageName = 0
    
    var clock: CALayer?
    //定时旋转需要用到秒针
    var second: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        
//        clockWithCALayer()
        //手动调用解决秒针初始旋转角偏移
//        self.rotateSecond()
    }
    
    //MARK: - CALayer
    
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
        
        self.clock = clockLayer

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
    
    //MARK: - Core Animation
    
    //MARK: - Core Animation - CATrisition
    /**
     *  Desc: 转场动画：CATrisition
     *  Param:CATransaction是事务不是动画：let action = CATransaction()
     */
    @IBAction func changePage(_ sender: UISwipeGestureRecognizer) {
        if imageName == 5 {
            imageName = 0
        }else if imageName == -1 {
            imageName = 0
        }
        self.pageImageView.image = self.images[imageName]
        
        //1.新建转场动画
        let anim = CATransition()
        //2.设置动画类型：通过字符串指定系统自动完成动画效果
        //        类型字符串    效果说明    关键字    方向
        //        fade    交叉淡化过渡    YES
        //        push    新视图把旧视图推出去     YES
        //        moveIn    新视图移到旧视图上面    YES
        //        reveal    将旧视图移开,显示下面的新视图     YES
        //        cube    立方体翻滚效果
        //        oglFlip    上下左右翻转效果
        //        suckEffect    收缩效果，如一块布被抽走        NO
        //        rippleEffect    水滴效果        NO
        //        pageCurl    向上翻页效果
        //        pageUnCurl    向下翻页效果
        //        cameraIrisHollowOpen    相机镜头打开效果        NO
        //        cameraIrisHollowClose    相机镜头关闭效果        NO
        anim.type = "cube"  //3D翻转
        anim.type = "fade"  //渐变
        anim.type = "rippleEffect"
        
        
        //判断两个轻扫手势的方向：手指轻扫方向决定左右
        if sender.direction == UISwipeGestureRecognizerDirection.left {
            imageName = imageName + 1
            //4.改变动画方向
            anim.subtype = kCATransitionFromLeft
        }else if sender.direction == UISwipeGestureRecognizerDirection.right {
            imageName = imageName - 1
            //4.改变动画方向
            anim.subtype = kCATransitionFromRight
        }
        
        //3.添加动画到layer上
        self.pageImageView.layer.add(anim, forKey: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        animateOfBasic()
//        animateOfKeyframe()
        animateOfGroup()
    }
    
    /**
     *  Desc: 属性动画之基本动画：实现平移layer
     *  Param: 基本动画执行完会回到原来的位置上
     */
    private func animateOfBasic() {
        //初始化一个基本动画
        let base = CABasicAnimation()
        //通过指定属性来确定动画方式
        base.keyPath = "position.x"
        //设置属性的值变化
        base.fromValue = 10
        base.toValue = 300
        //设置动画执行时间
        base.duration = 3
        //byValue表示在原来的基础上累加10
        //base.byValue = 10
        //不希望回到原来位置
        base.fillMode = kCAFillModeForwards
        base.isRemovedOnCompletion = false
        
        
        //将动画添加到layer上
        self.clock?.add(base, forKey: nil)
        self.second?.add(base, forKey: nil)
    }
    
    /**
     *  Desc: 属性动画之关键帧动画
     *  Param: 基本动画执行完会回到原来的位置上
     */
    private func animateOfKeyframe() {
        //初始化一个关键帧动画
        let keyframe = CAKeyframeAnimation()
        //通过指定属性来确定动画方式
        keyframe.keyPath = "position"
        //设置属性的值变化：1.根据CGPoint连线路径来执行动画
        //将点转为Value对象
        let p1 = CGPoint(x: 0, y: 50)
        let v1 = NSValue(cgPoint: p1)
        let p2 = CGPoint(x: 300, y: 50)
        let v2 = NSValue(cgPoint: p2)
        let p3 = CGPoint(x: 0, y: 250)
        let v3 = NSValue(cgPoint: p3)
        let p4 = CGPoint(x: 300, y: 250)
        let v4 = NSValue(cgPoint: p4)
//        keyframe.values = [v1, v2, v3, v4]
        
        //2.根据UIBezierPath路径来执行动画
        //绘制路径
        let path = UIBezierPath()
        path.addArc(withCenter: self.view.center, radius: 100, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        //设置路径给关键帧
        keyframe.path = path.cgPath
        
        //设置动画执行时间
        keyframe.duration = 3
        
        //是否重复执行
        //keyframe.repeatCount = MAXFLOAT
        
        //byValue表示在原来的基础上累加10
        //base.byValue = 10
        //不希望回到原来位置
        keyframe.fillMode = kCAFillModeForwards
        keyframe.isRemovedOnCompletion = false
        
        
        //将动画添加到layer上
        self.clock?.add(keyframe, forKey: nil)
        self.second?.add(keyframe, forKey: nil)
    }
    
    /**
     *  Desc: 组动画
     *  Param:
     */
    private func animateOfGroup() {
        //初始化一个基本动画
        let group = CAAnimationGroup()
        
        //-------------------------------------
        //初始化一个基本动画
        let base = CABasicAnimation()
        //通过指定属性来确定动画方式
        //自转
        base.keyPath = "transform.rotation"
        //设置属性的值变化
        base.fromValue = 0
        base.toValue = 2*Double.pi * 2
        //-------------------------------------
        
        //-------------------------------------
        //初始化一个关键帧动画
        let keyframe = CAKeyframeAnimation()
        //通过指定属性来确定动画方式：公转
        keyframe.keyPath = "position"
        //2.根据UIBezierPath路径来执行动画
        //绘制路径
        let path = UIBezierPath()
        path.addArc(withCenter: self.view.center, radius: 100, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        //设置路径给关键帧
        keyframe.path = path.cgPath
        //-------------------------------------
        
        //设置动画执行时间
        group.duration = 3
        //byValue表示在原来的基础上累加10
        //base.byValue = 10
        //不希望回到原来位置
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        
        //将动画添加到Group动画中
        group.animations = [base, keyframe]
        
        //将动画添加到layer上
        self.clock?.add(group, forKey: nil)
        self.second?.add(group, forKey: nil)
    }
    
    
    
}
