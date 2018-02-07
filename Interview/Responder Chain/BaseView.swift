//
//  BaseView.swift
//  Interview
//
//  Created by mac on 2018/1/31.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /*
     UIView不能与用户交互的三种情况：
     1.UIView的透明度小于0.01时控件不能响应事件
     2.设置控件的isUserInteractionEnabled为false时不能响应事件
     3.设置控件的isHidden为true时不能响应事件
     */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //测试
        debugPrint("hitTest >>> \(self.classForCoder)")
        return super.hitTest(point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //测试
        debugPrint("touchesBegan >>> \(self.classForCoder)")
        super.touchesBegan(touches, with: event)
    }
}
