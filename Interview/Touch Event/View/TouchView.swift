//
//  TouchView.swift
//  Interview
//
//  Created by mac on 2018/3/10.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

/**
 *  Desc: 一个自身跟随手指移动的View
 *  Param:
 */
class TouchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取触摸对象：单点触控
        let touch = touches.first
        //移动时改变touchView位置跟随移动
        
        //方式1：通过center = 触摸点位置
        //touchView.center = (touch?.location(in: touchView.superview))!
        //方式2：通过center = center点位置 + 偏移量
        //获取上一个点坐标
        let pre = touch?.previousLocation(in: self)
        //获取下一个点坐标
        let current = touch?.location(in: self)
        //计算偏移量
        let x: CGFloat = (current?.x)! - (pre?.x)!
        let y: CGFloat = (current?.y)! - (pre?.y)!
        //计算偏移后的位置
        let point = CGPoint(x: self.center.x + x, y: self.center.y + y)
        //改变View位置
        self.center = point
        
    }
}
