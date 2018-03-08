//
//  CustomProgressView.swift
//  Interview
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

/**
 *  Desc: 第三方框架：xyPieChart
 *  Param:
 */
class CustomProgressView: UIView {

    var progressValue: CGFloat = 0 {
        didSet {
            //重绘View
            self.setNeedsDisplay()
            //设置valueLabel的值：%% = "%"
            valueLabel.text = String.init(format: "%.2f%%", progressValue * 100)
        }
    }
    
    @IBOutlet weak var valueLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        getProgressViewWith()
    }

    private func getProgressViewWith() {
        //1.绘制圆弧
        var start: CGFloat = CGFloat(0 - Double.pi/2)
        var end: CGFloat = 0
        //计算结束角度（位置）
        end = CGFloat(2 * Double.pi) * progressValue + start
        let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        let radius:CGFloat = 100
        //初始化路径
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        //2.连接圆心
        let x: CGFloat = CGFloat(arc4random_uniform(240))
        let y: CGFloat = CGFloat(arc4random_uniform(240))
        let randomPoint = CGPoint(x: x, y: y)
        path.addLine(to: center)
        //关闭路径
        path.close()
        //2.3 设置上下文样式：
        getRandomColor().setFill()
        getRandomColor().setStroke()
        path.lineWidth = 1
        //3.渲染界面（真正绘制到界面上）
        path.fill()
        path.stroke()
        //计算下一次开始角度（位置）
//        start = end
    }
    
    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    }
}
