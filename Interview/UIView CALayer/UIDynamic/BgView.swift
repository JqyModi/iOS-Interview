//
//  BgView.swift
//  Interview
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class BgView: UIView {

    var startPoint: CGPoint? = CGPoint.zero
    var endPoint: CGPoint? = CGPoint.zero
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        path.move(to: startPoint!)
        path.addLine(to: endPoint!)
        path.stroke()
    }

}
