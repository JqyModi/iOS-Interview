//
//  BgCircleView.swift
//  Interview
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class BgCircleView: UIView {

    var centerPoint: CGPoint = CGPoint.zero
    var radius: CGFloat = 100
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        path.addArc(withCenter: self.centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        randomColor.set()
        path.lineWidth = 2
        path.stroke()
        
        //绘制一个圆心
        let path1 = UIBezierPath()
        path1.addArc(withCenter: self.centerPoint, radius: 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path1.stroke()
    }

}
