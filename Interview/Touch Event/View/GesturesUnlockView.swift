//
//  GesturesUnlockView.swift
//  Interview
//
//  Created by mac on 2018/3/10.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

/**
 *  Desc: 手势解锁View
 *  Param:
 */
class GesturesUnlockView: UIView {
    
    //定义一个block给外部调用
    var checkPassBlock: ((_ pass: String) -> Bool)?
    
    //定义宏：表示宫格数 9
    static let btnCount = 9
    static let lineCount: CGFloat = 3
    
    //记录当前手指触摸的位置
    var currentPoint: CGPoint?
    var highlightBtns: [UIButton]? = {
        let btn = [UIButton]()
        return btn
    }()
    
    //懒加载创建并将9个Button用数组管理
    lazy var array: [UIButton]? = {
        var arr = [UIButton]()
        for index in (0...GesturesUnlockView.btnCount) {
            let btn = UIButton()
            btn.tag = index
            btn.setImage(UIImage(named: "gesture_node_normal"), for: .normal)
            btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .selected)
            btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .highlighted)
            btn.setImage(UIImage(named: "gesture_node_error"), for: .disabled)
            //btn禁止用户交互：通过touchbeagin来响应操作
            btn.isUserInteractionEnabled = false
            //添加到数组
            arr.append(btn)
        }
        return arr
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //布局子控件
        setupUI()
    }
    
    //布局控件到View上：九宫格布局：坐标计算
    private func setupUI() {
        //获取到每个控件
        for var i in 0..<array!.count-1 {
            var btn = array![i]
            //设置每个按钮的frame
            
            //设置按钮大小
            let width: CGFloat = 74
            let height = width
            
            //设置按钮间距
            let margin = (self.bounds.width - GesturesUnlockView.lineCount * width) / (GesturesUnlockView.lineCount + 1)
            debugPrint("margin --> \(margin)")
            //计算每个按钮的x
            debugPrint("行号 - \(CGFloat(i).truncatingRemainder(dividingBy: GesturesUnlockView.lineCount))")
            let x = CGFloat(i).truncatingRemainder(dividingBy: GesturesUnlockView.lineCount) * (width + margin) + margin
            // i / lineCount 取整才不会发生偏移
            let y = CGFloat(Int(CGFloat(i) / GesturesUnlockView.lineCount)) * (height + margin) + margin
            debugPrint("y -- \(y)")
            
            let rect = CGRect(x: x, y: y, width: width, height: height)
            btn.frame = rect
            //将按钮添加到View上
            self.addSubview(btn)
        
        }
    }
    
    override func draw(_ rect: CGRect) {
        //绘制按钮与按钮及按钮与手指间的连线
        if highlightBtns?.count == 0 {
            return
        }
        //获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        //绘制路径
        let path = UIBezierPath()
        
        for var i in 0..<highlightBtns!.count {
            let btn = highlightBtns![i]
            if i == 0 {
                path.move(to: btn.center)
            }else {
                path.addLine(to: btn.center)
            }
        }
        
        //添加最后一个高亮按钮到当前手指间的连线
        path.addLine(to: self.currentPoint!)
        
        //将路径添加到上下文
        context?.addPath(path.cgPath)
        
        //设置线的样式
        let lineWidth: CGFloat = 10
        context?.setLineWidth(lineWidth)
        //设置线颜色
        UIColor.white.set()
        //设置线头样式
        context?.setLineCap(.round)
        //设置连接处样式
        context?.setLineJoin(.round)
        //渲染
        context?.strokePath()
    }

    //手指点击时改变按钮状态
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取触摸对象
        let touch = touches.first
        //判断当前触摸坐标是否在某个btn的frame上：在则改变状态为选中
        for btn in array! {
            let p = touch?.location(in: touch?.view)
            //CGRect的contains方法判断一个点是否在frame上
            if ((btn.frame).contains(p!)) {
                //btn.isSelected = true
                btn.isSelected = true
                //是否需要添加到高亮数组中
                highlightBtns?.append(btn)
            }
        }
    }
    
    //手指划过时改变经过按钮的状态为选中
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //获取触摸对象
        let touch = touches.first
        let p = touch?.location(in: touch?.view)
        //赋值当前手指位置坐标
        self.currentPoint = p
        //判断当前触摸坐标是否在某个btn的frame上：在则改变状态为选中
        for btn in array! {
            //CGRect的contains方法判断一个点是否在frame上
            if ((btn.frame).contains(p!)) {
                //btn.isSelected = true
                btn.isSelected = true
                //判断按钮是否重复添加
                if !(highlightBtns?.contains(btn))! {
                    //将高亮的按钮加入到高亮数组中
                    highlightBtns?.append(btn)
                }

            }
        }
        //重绘显示连线
        self.setNeedsDisplay()
    }
    
    //手指移开时取消按钮选中状态
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //去掉错误手势显示时多出来到手指触摸点的连线
        let btn = highlightBtns?.last
        self.currentPoint = btn?.center
        //重绘界面
        self.setNeedsDisplay()
        
        //生成及判断密码
        getPassOfHighlightBtns()
        
        //获取触摸对象
        let touch = touches.first
        //改变按钮状态为disable = true显示错误手势图片
        for var i in 0..<highlightBtns!.count {
            let btn = highlightBtns![i]
            //设置按钮不可以同时需要更改选中状态为false
            btn.isSelected = false
            btn.isEnabled = false
        }
        
        //解决手势错误后继续编辑问题：1.禁用用户交互
        self.isUserInteractionEnabled = false
        
        //延时1秒钟显示错误密码手势
        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //2.开启用户交互
            self.isUserInteractionEnabled = true
            self.clear()
        }
//        perform(#selector(GesturesUnlockView.clear), with: self, afterDelay: time)
    }
    
    private func getPassOfHighlightBtns() {
        //生成手势密码
        var pass = ""
        for btn in highlightBtns! {
            pass = pass.appendingFormat("%d", btn.tag)
        }
        //调用block
        if (checkPassBlock != nil) {
            if checkPassBlock!(pass) {
                debugPrint("密码正确")
                SVProgressHUD.showSuccess(withStatus: "密码正确")
            }else {
                debugPrint("密码错误")
                SVProgressHUD.showError(withStatus: "密码错误")
            }
        }
        debugPrint("pass ---> \(pass)")
    }
    
    @objc private func clear() {
        //判断当前触摸坐标是否在某个btn的frame上：在则改变状态为选中
        for btn in array! {
            btn.isSelected = false
            //恢复可用状态
            btn.isEnabled = true
        }
        //取消按钮间的连线
        highlightBtns?.removeAll()
        //重绘界面
        self.setNeedsDisplay()
    }
}
