//
//  PieView.swift
//  Interview
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit
import CoreGraphics

class PieView: UIView {
    
    /**
     *  Desc: 1.rect表示当前View的Bounds
     *        2.该方法能获取到正确的上下文：不能手动调用
     *        3.该方法在第一次使用和重绘时会调用：setNeedsDisplay() /setNeedsDisplay(<#T##rect: CGRect##CGRect#>)
     *  Param:
     */
    override func draw(_ rect: CGRect) {
        // Drawing code
        //获取上下文对象：layer类型上下文
        let context = UIGraphicsGetCurrentContext()
        let array: Array<CGFloat> = [0.1, 0.3, 0.1, 0.3, 0.2]
//        getPieOfCWithArray(context: context!, array: array)
        
        getPieOfOCWithArray(array: array)
    }

    /**
     *  Desc: C方式绘制扇形
     *  Param:
     */
    private func getPieOfCWithArray(context: CGContext, array: Array<CGFloat>) {
        //1.获取上下文（类似草稿没有真正绘制到界面上）
        let context = context
        /*
        //2.绘制路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 100))
        //2.1 将路径添加到上下文
        context.addPath(path)
        //2.2 关闭路径（可选）
        context.closePath()
        //3.渲染界面（真正绘制到界面上）
        context.strokePath()
        */
        
        //绘制圆弧再与圆心连线最后关闭路径就是一个扇形图
        
        //1.绘制圆弧
        var start: CGFloat = 0
        var end: CGFloat = 0
        
        for value in array {
            //计算结束角度（位置）
            end = CGFloat(2 * Double.pi) * value + start
            //center不能直接用self.center：因为self.center是根据父控件计算出来的
            let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
            let radius:CGFloat = 100
            let path = CGMutablePath()
            path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
            //2.连接圆心
            path.addLine(to: center)
            //2.1 将路径添加到上下文
            context.addPath(path)
            //2.2 关闭路径（可选）
//            context.closePath()
            //2.3 设置上下文样式：
            getRandomColor().setFill()
            getRandomColor().setStroke()
            context.setLineWidth(2)
            //3.渲染界面（真正绘制到界面上）
//            context.drawPath(using: CGPathDrawingMode.fillStroke)
            context.strokePath()
            //计算下一次开始角度（位置）
            start = end
            
        }
        
    }
    
    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
    
    /**
     *  Desc: OC方式绘制扇形
     *  Param: 说明OC方式虽然看起来没有上下文，但是内部会自动获取上下文并操作所有还是需要在draw方法中完成绘图
     */
    private func getPieOfOCWithArray(array: Array<CGFloat>) {
        //1.绘制圆弧
        var start: CGFloat = 0
        var end: CGFloat = 0
        
        for value in array {
            //计算结束角度（位置）
            end = CGFloat(2 * Double.pi) * value + start
            let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
            let radius:CGFloat = 100
            //初始化路径
            let path = UIBezierPath()
            path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
            //2.连接圆心
            path.addLine(to: center)
            //关闭路径
            path.close()
            //2.3 设置上下文样式：
            getRandomColor().setFill()
            getRandomColor().setStroke()
            path.lineWidth = 2
            //3.渲染界面（真正绘制到界面上）
            path.fill()
            path.stroke()
            //计算下一次开始角度（位置）
            start = end
        }
        
    }
    
}
