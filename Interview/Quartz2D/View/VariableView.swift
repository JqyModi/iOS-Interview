//
//  VariableView.swift
//  Interview
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class VariableView: UIView {

    var progressValue: CGFloat? {
        didSet {
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        //获取上下文对象：layer类型上下文
        let context = UIGraphicsGetCurrentContext()
        let array: Array<CGFloat> = [0.1, 0.3, 0.1, 0.3, 0.2]
        getPieOfCWithArray(context: context!, array: array)
    }
 
    /**
     *  Desc: C方式绘制扇形
     *  Param:
     */
    private func getPieOfCWithArray(context: CGContext, array: Array<CGFloat>) {
        //1.获取上下文（类似草稿没有真正绘制到界面上）
        let context = context

        //1.1 保存layer图形上下文到栈：入栈：保存初始化时样式信息
        context.saveGState()
        
        //2.绘制路径
        let path = CGMutablePath()

        //变换上下文
        //1.旋转：整个上下文绕着（0，0）旋转
//        context.rotate(by: CGFloat(-Double.pi/8))
        //2.平移：整个上下文以（0，0）为参照平移
//        context.translateBy(x: 20, y: 30)
        //3.缩放：整个上下文以本身为参照在x,y方向倍数缩放：如0.5表示缩放到一半
//        context.scaleBy(x: 1.2, y: 0.5)
        
        /*
        //1.绘制圆弧
        var start: CGFloat = CGFloat(Double.pi/2)
        var end: CGFloat = CGFloat(Double.pi*2/3)
        //center不能直接用self.center：因为self.center是根据父控件计算出来的
        let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        let radius:CGFloat = 100
        path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        //2.连接圆心
        path.addLine(to: center)
        //2.1 将路径添加到上下文
        context.addPath(path)
        //2.2 关闭路径（可选）
        context.closePath()
        //2.3 设置上下文样式：
        getRandomColor().setFill()
        getRandomColor().setStroke()
        context.setLineWidth(2)
        //3.渲染界面（真正绘制到界面上）
        context.strokePath()
        
        //恢复layer上下文栈：出栈 恢复初始化时样式信息
        context.restoreGState()
        //绘制下一条路径
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 100))
        //2.1 将路径添加到上下文
        context.addPath(path)
        //第二次渲染
        context.strokePath()
        */
        
        //文字绘制
        let s: NSString = "hello Siri ~ 空空如也 - 胡66 词：雪无影 曲：雪无影 熟悉的陌生的这种感觉 重复的曾经的那些情节也只是怀念一滴滴一点点一页一篇分手了也不过三百多天可我却害怕遇见我懵懵懂懂过了一年这一年似乎没有改变守着你离开后的世界空空如也白天和晚上都是冬夜悲伤的到来我从不拒绝反正亦是空空空空如也"
        //1.从一个指定点开始绘制：自动调用上下文绘制文字：NSString封装
        let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
//        s.draw(at: point, withAttributes: nil)
        //2.在指定矩形区域里面绘制文字：自动换行
        let rect = CGRect(x: 0, y: 40, width: 240, height: 150)
//        s.draw(in: rect, withAttributes: nil)
        
        //绘制图片：Image的draw方法，Image封装内部自动调用上下文绘制
        let image = UIImage(named: "icon_02")
        //从指定point开始绘制：point = 图片左上角 : 大小等于图片本身大小
//        image?.draw(at: center)
        //在指定rect范围内绘制：全图绘制：rect大小小于图片本身大小会变形
//        image?.draw(in: rect)
        //平铺方式绘制图片：图片大小小于rect的大小时重复绘制平铺满rect
//        image?.drawAsPattern(in: rect)
        //可控制颜色混合模式及透明度绘制：可以绘制出散点效果color、黑白效果luminosity等等
//        image?.draw(in: rect, blendMode: .luminosity, alpha: 1)

        //裁剪上下文可视区域实现图片裁剪效果：图片本身是矩形，只是被裁剪区域外变为透明
        //1.绘制裁剪路径区域：一个圆弧
        context.addArc(center: center, radius: 100, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        //执行裁剪操作
        context.clip()
        //先裁剪再渲染（绘制）
        image?.draw(in: rect, blendMode: .luminosity, alpha: 1)
    }
    
    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
}
