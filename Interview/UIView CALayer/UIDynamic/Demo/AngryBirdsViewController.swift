//
//  AngryBirdsViewController.swift
//  Interview
//  愤怒的小鸟
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class AngryBirdsViewController: UIViewController, UICollisionBehaviorDelegate {

    var birdView: UIView?
    
    var targetView: UIView?
    
    var bgView: BgCircleView?
    
    lazy var animator: UIDynamicAnimator = {
       let animate = UIDynamicAnimator(referenceView: self.view)
        return animate
    }()
    
    var grivity: UIGravityBehavior = {
        let g = UIGravityBehavior()
        return g
    }()
    
    //加载背景View
    override func loadView() {
        self.bgView = BgCircleView(frame: UIScreen.main.bounds)
        self.view = bgView
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    private func initView() {
        birdView = UIView()
        birdView?.frame = CGRect(x: 80, y: 250, width: 50, height: 50)
        birdView?.backgroundColor = getRandomColor()
        self.view.addSubview(birdView!)
        
        //绘制背景圆圈
        bgView?.centerPoint = (birdView?.center)!
        bgView?.setNeedsDisplay()
        
        //添加拖拽手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(AngryBirdsViewController.birdViewPan(gesture:)))
        birdView?.addGestureRecognizer(pan)
        
        targetView = UIView()
        targetView?.frame = CGRect(x: 560, y: 300, width: 50, height: 50)
        targetView?.backgroundColor = getRandomColor()
        self.view.addSubview(targetView!)
        
        //给两个View添加碰撞手势
        let collision = UICollisionBehavior(items: [birdView!, targetView!])
        
        //设置代理事件
        collision.collisionDelegate = self
        
        //将引用的View作为边界
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        //先将重力添加到动画执行者上后面需要在更改目标View即可:解决重复添加
        animator.addBehavior(self.grivity)
    }
    
    //MARK: - UICollisionBehaviorDelegate
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        //两个item相撞时调用
        
        //给被撞的item加上重力场
        self.grivity.addItem(self.targetView!)
        //添加到执行者上：不需要添加了 已经添加过了
//        self.animator.addBehavior(self.grivity!)
        debugPrint("666666666 ---- \(animator.description)")
    }
    
    @objc private func birdViewPan(gesture: UIPanGestureRecognizer) {
        //添加Core Animation ：动画执行完毕回到原来位置
        
        //当前手指触摸点
        let currentPoint = gesture.location(in: self.view)
//        debugPrint("currentPoint -----> \(NSStringFromCGPoint(currentPoint))")
        //计算移动的偏移向量：相当于：CGVector : gesture.view = self.view 效果一样
        let offsetPoint = gesture.translation(in: gesture.view)
        
//        debugPrint("offsetPoint -----> \(NSStringFromCGPoint(offsetPoint))")
        
        /*
        //通过偏移向量的x,y计算出birdView的中心与当前手指触摸点的向量大小而不是实际距离
        let tempX = offsetPoint.x * offsetPoint.x
        let tempY = offsetPoint.y * offsetPoint.y
        //勾股定理计算斜边的向量大小
        let distanceVector = sqrt(tempX + tempY)
        debugPrint("斜边向量大小 ----> \(distanceVector)")
        */
        
        // 计算最后的偏移量：通过坐标差值 + 勾股定理计算
        let offsetX = (gesture.view?.center.x)! - currentPoint.x
        let offsetY = (gesture.view?.center.y)! - currentPoint.y
        // 计算拖动的距离
        let distance1 = sqrt(offsetX * offsetX + offsetY * offsetY)
//        debugPrint("斜边长1 ----> \(distance1)")
        
        //判断当前手指偏移量是否超出范围
        let path = UIBezierPath()
        let radius = 100
        path.addArc(withCenter: (gesture.view!.center), radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        if path.contains(currentPoint) {
            //在当前范围内：撒手时给增加重力和push力
            if gesture.state == UIGestureRecognizerState.ended {
                //添加重力
//                let gravity1 = UIGravityBehavior(items: [birdView!])
//                self.grivity = gravity1
                self.grivity.addItem(gesture.view!)
                //添加到动画执行者
//                animator.addBehavior(gravity1)

                //添加push力
                let push = UIPushBehavior(items: [gesture.view!], mode: .instantaneous)
                //计算并设置推力的大小
                push.magnitude = resultWithConsult(consule: distance1, resultValue: YHValue(startValue: 0,endValue: 1), consultValue: YHValue(startValue: 0,endValue: 100))

                //通过向量计算推力方向：偏移向量的反方向
                let offsetVector = CGVector(dx: currentPoint.x - (gesture.view?.center.x)!, dy: currentPoint.y - (gesture.view?.center.y)!)
                //取反方向弹出去
                let convertVector = CGVector(dx: -offsetVector.dx, dy: -offsetVector.dy)
                //设置推力的方向
//                push.angle = 0
                push.pushDirection = convertVector
                //添加到动画执行者
                animator.addBehavior(push)
            }
        }else {
            return
        }
        
        //拖动改变birdView位置
//        birdView?.layer.setAffineTransform(CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y))
        gesture.view?.transform = CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y)
        
        // 手势归0
//        gesture.setTranslation(CGPoint.zero, in: gesture.view)
    }

    private func getRandomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
    
    /**
     *  根据参考获取结果
     *  @param consule      参考值
     *  @param resultValue  结果的start到end
     *  @param consultValue 参考的start到end
     *  @return 结果指
     */
    private func resultWithConsult(consule: CGFloat, resultValue: YHValue, consultValue: YHValue) -> CGFloat {
    // 0 - 100
    // 0 - 1
    // a * r.start + b = c.start
    // a * r.end + b = c.end
    // a * (r.start - r.end) + b = c.start - c.ent;
    let a = (resultValue.startValue - resultValue.endValue) / (consultValue.startValue - consultValue.endValue)
    let b = resultValue.startValue - (a * consultValue.startValue)
    return a * consule + b
    }
    
}

struct YHValue {
    var startValue: CGFloat
    var endValue: CGFloat
}
